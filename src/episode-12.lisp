(in-package :coding-math)

(with-sketch wrapping-up ((sun (particle-create center-x center-y 0 0)))

  (update planet)

  (with-pen (make-pen :fill +yellow+ :stroke +orange+)
    (circle center-x center-y 20))

  (with-pen (make-pen :fill +green+ :stroke +green+)
    (circle (particle-x planet) (particle-y planet) 10)))


(with-sketch wrapping-up ((p (particle-create center-x center-y 1 (* (random 1.0) pi 2))))
  (flet ((check-borders ()
           (with-slots (position velocity radius) p
             (with-slots (x y ) position
               (cond ((> (- x radius) width) (setf x (* -1 radius)))
                     ((< (+ x radius) 0) (setf x (+ width radius)))
                     ((> (- y radius) height) (setf y (* -1 radius)))
                     ((< (+ y radius) 0) (setf y (+ height radius))))))))
    (check-borders)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (update p)
      (circle (particle-x p) (particle-y p) 50))))

(with-sketch wrapping-up ((p (particle-create center-x center-y 1 (* (random 1.0) pi 2))))
  (flet ((check-borders ()
           (with-slots (position velocity radius) p
             (with-slots (x y ) position
               (cond ((> (- x radius) width) (setf x (* -1 radius)))
                     ((< (+ x radius) 0) (setf x (+ width radius)))
                     ((> (- y radius) height) (setf y (* -1 radius)))
                     ((< (+ y radius) 0) (setf y (+ height radius))))))))
    (check-borders)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (update p)
      (circle (particle-x p) (particle-y p) 50))))
