(defpackage :the-witness.util.pathfinding
  (:use :common-lisp
        :the-witness.core.point
        :cl-utilities)
  (:export #:find-paths
           #:paint-path))

(in-package :the-witness.util.pathfinding)

(defun find-paths (start finish puzzle)
  (let ((stack (list (list start (list start))))
        (all-paths '()))
    (loop while (not (null stack))
          for (vertex path) = (pop stack) do
            (loop for neighbour in (point-neighbours vertex puzzle :filter ".")
                  for new-path = (cons neighbour path)
                  when (not (member neighbour path :test #'equalp)) do
                    (if (equalp neighbour finish)
                        (push new-path all-paths)
                        (push (list neighbour new-path) stack))))
    all-paths))

(defun paint-path (path puzzle)
  (destructuring-bind (height width) (array-dimensions puzzle)
    (let ((puzzle (cl-utilities:copy-array puzzle)))
      (loop for y from 0 to (1- height) do
        (loop for x from 0 to (1- width)
              for point = (make-point :x x :y y)
              when (member point path :test #'equalp) do
                (setf (aref puzzle y x) "x")))
      puzzle)))
