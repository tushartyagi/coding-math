(in-package :coding-math)

(defmacro with-sketch (name bindings &body body)
  `(defsketch ,name ((width 800) (height 600)
                     (center-x (/ width 2))
                     (center-y (/ height 2))
                     ,@bindings)
     (background +white+)
     ,@body))
