(defpackage :the-witness.puzzles.solver
  (:use :common-lisp
        :the-witness.util.partition
        :the-witness.util.pathfinding
        :the-witness.core.point)
  (:export #:count-char
           #:solve))

(in-package :the-witness.puzzles.solver)

(defun count-char (char points puzzle)
  (count-if #'(lambda (point)
                (equal char (aref puzzle (point-y point) (point-x point))))
            points))

(defun render (puzzle)
  (destructuring-bind (height width) (array-dimensions puzzle)
    (loop for y from 0 to (1- height) do
      (loop for x from 0 to (1- width)
            for point = (make-point :x x :y y) do
              (princ (aref puzzle y x)))
      (princ #\Newline))
    (princ #\Newline)))

(defun solve (start finish valid-solution? puzzle)
  (let ((all-paths (find-paths start finish puzzle)))
    (loop for path in all-paths
          for solved-puzzle = (paint-path path puzzle)
          when (funcall valid-solution? (partitions start solved-puzzle) solved-puzzle) do
            (render solved-puzzle)
          (princ #\Newline))))
