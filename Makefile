BUILD_DIR ?= build

CC ?= gcc
EMACS ?= emacs
LATEX ?= pdflatex
LUA ?= lua
PYTHON ?= python

ALL_SRC = $(wildcard heart*.*)
ALL_TGT = $(basename ${ALL_SRC})

all: ${ALL_TGT}

.PHONY: list
list:
	@echo ${ALL_TGT}

.PHONY: ${ALL_TGT}

${BUILD_DIR}:
	[ -d "${BUILD_DIR}" ] || mkdir "${BUILD_DIR}"

heart_c: ${BUILD_DIR}/heart_c
	$<

${BUILD_DIR}/heart_c: heart_c.c ${BUILD_DIR}
	${CC} -Wall -Wextra -O1 -s $< -o $@

heart_elisp: heart_elisp.el
	${EMACS} --batch --load $<

heart_latex: ${BUILD_DIR}/heart_latex.pdf
	xdg-open $<

${BUILD_DIR}/heart_latex.pdf: heart_latex.tex ${BUILD_DIR}
	${LATEX} -interaction=nonstopmode -file-line-error \
		-output-directory="$(dir $@)" "$<"

heart_lua: heart_lua.lua
	${LUA} $<

heart_python: heart_python.py
	${PYTHON} $<
