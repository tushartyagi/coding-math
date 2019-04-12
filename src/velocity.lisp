(in-package :coding-math)

(defmacro with-sketch (name bindings &body body)
  `(defsketch ,name ((width 800) (height 600)
                    (center-x (/ width 2))
                    (center-y (/ width 2))
                     ,@bindings)
     (background +white+)
     ,@body))


(with-sketch my-example ((speed 12)
                         (xs 0.01))
  (with-pen (make-pen :fill +black+ :stroke +black+)
    (rect 0 0 100 100)))
