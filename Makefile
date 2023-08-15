BUILD_DIR ?= build

CC ?= gcc
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

heart_python: heart_python.py
	${PYTHON} $<
