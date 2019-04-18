(in-package :coding-math)

(with-sketch wrapping-up ((planet (particle-create center-x center-y 0 0)))
  (with-pen (make-pen :fill +yellow+ :stroke +orange+)
    (circle center-x center-y 20))
  (with-pen (make-pen :fill +green+ :stroke +green+)
    (circle (particle-x planet) (particle-y planet) 10)))


(with-sketch wrapping-up ((p (particle-create center-x center-y 1 (* (random 1.0) pi 2))))
  (flet ((calculate-borders ()
           (with-slots (position velocity radius) p
             (with-slots (x y ) position
               (cond ((> (- x radius) width) (setf x (* -1 radius)))
                     ((< (+ x radius) 0) (setf x (+ width radius)))
                     ((> (- y radius) height) (setf y (* -1 radius)))
                     ((< (+ y radius) 0) (setf y (+ height radius))))))))
    (calculate-borders)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (update p)
      (circle (particle-x p) (particle-y p) 50))))

(with-sketch wrapping-up ((p (particle-create center-x center-y 1 (* (random 1.0) pi 2))))
  (flet ((calculate-borders ()
           (with-slots (position velocity radius) p
             (with-slots (x y ) position
               (cond ((> (- x radius) width) (setf x (* -1 radius)))
                     ((< (+ x radius) 0) (setf x (+ width radius)))
                     ((> (- y radius) height) (setf y (* -1 radius)))
                     ((< (+ y radius) 0) (setf y (+ height radius))))))))
    (calculate-borders)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (update p)
      (circle (particle-x p) (particle-y p) 50))))


(with-sketch fountain ((particle-count 100)
                       (particles (fill-particles center-x center-y particle-count))
                       (gravity (make-vector 0 0.1)))
  (labels ((update-frame ()
           (dotimes (i particle-count)
             (calculate-borders (aref particles i))
             (accelerate (aref particles i) gravity)
             (update (aref particles i))))
         (calculate-borders (p)
           (when (> (- (particle-y p) (particle-radius p)) height)
             (setf (particle-x p) center-x)
             (setf (particle-y p) height)
             (setf (speed p)  (+ (random 8) 3) )
             (setf (direction p) (+ (* -1 (/ pi 2)) (- (random 0.2) 0.1))))))
    (update-frame)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (iterate (for p in-vector particles)
               (with-slots (position) p
                 (circle (x position) (y position) 5))))))


(with-sketch bouncing-particle ((p (particle-create center-x center-y 15 (* (random 1.0) pi 2))))
  (flet ((calculate-borders ()
           (with-slots (position velocity radius bounce) p
             (with-slots (x y) position
               (cond ((> (+ x radius) width)
                      (progn
                        (setf x (- width radius))
                        (setf (x velocity) (* -1 bounce))))
                     ((< (- x radius) 0)
                      (progn
                        (setf x radius)
                        (setf (x velocity) (* -1 bounce))))
                     ((> (+ y radius) height)
                      (progn
                        (setf y (- height radius))
                        (setf (y velocity) (* -1 bounce))))
                     ((< (- y radius) 0)
                      (progn
                        (setf y radius)
                        (setf (y velocity) (* -1 bounce)))))))))
    (calculate-borders)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (update p)
      (circle (particle-x p) (particle-y p) 50))))
