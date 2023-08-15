;; -*- lexical-binding: t -*-

(require 'cl-macs)

(defun f (x y)
  (let ((x2 (* x x))
        (y2 (* y y))
        (y3 (* y y y)))
    (- (expt (+ x2 y2 -1) 3) (* x2 y3))))

(defconst *x-max* 1.3)
(defconst *x-min* (- *x-max*))
(defconst *y-max* 1.4)
(defconst *y-min* -1.1)

(defconst *term-width* 80)
(defconst *term-height* 24)

(defun draw ()
  (let ((x-step (/ (- *x-max* *x-min*) (- *term-width* 1)))
        (y-step (/ (- *y-max* *y-min*) (- *term-height* 1))))
    (cl-loop for y from *y-max* downto *y-min* by y-step
             do (message
                 "%s"
                 (apply #'concat
                        (cl-loop for x from *x-min* upto *x-max* by x-step
                                 collect (if (<= (f x y) 0) "@" " ")))))))

(draw)
