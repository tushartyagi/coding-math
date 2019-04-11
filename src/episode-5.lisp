(in-package :coding-math)

;; Episode 5 - Arc Tangent

(defsketch arrow
    ((width 800) (height 600)
     (center-x (* 0.5 width))
     (center-y (* 0.5 height))
     (angle 0))
  (background +white+)
  (with-pen (make-pen :fill +black+ :stroke +black+)
    (ngon 3 center-x center-y 12 6 angle)))

(defsketch rotating-triangle
    ((width 800) (height 800)
     (center-x (/ width 2))
     (center-y (/ height 2))
     (arrow-x (/ width 2))
     (arrow-y (/ height 2))
     (angle 0))
  (background +white+)
  (with-pen (make-pen :fill +red+ :stroke +red+)
    (circle 0 0 3)
    (circle center-x center-y 6)
    (line 0 0 width 0)
    (line 0 0 0 height))
  (translate arrow-x arrow-y)
  (rotate angle)
  (with-pen  (make-pen :fill +green+ :stroke +green+)
    (circle 0 0 3)
    (ngon 3 0 0 10 15 angle)))

(defmethod kit.sdl2:mousemotion-event ((triangle rotating-triangle)
                                       timestamp button-mask x y xrel yrel)
  (declare (ignore timestamp button-mask))
  (with-slots (width height angle) triangle
    (let* ((center-y (/ height 2))
           (center-x (/ width 2))
           (mouse-x (- x center-x))
           (mouse-y (- y center-y))
           (mouse-angle (atan mouse-y mouse-x)))
      (format t "~a, ~a, ~a~%" mouse-y mouse-x mouse-angle)
      (setf angle (* 10  mouse-angle)))))
