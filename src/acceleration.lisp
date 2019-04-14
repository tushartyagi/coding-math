(in-package :coding-math)

(with-sketch accelerating-particle ((p (particle-create 10 height 10 (* -1 (/ PI 2))))
                          (accel (make-vector 0.1 0.1)))
  (flet ((update ()
           (accelerate p accel)
           (update p)))
    (update)
    (with-pen (make-pen :fill +red+ :stroke +black+)
      (with-slots (position) p
        (circle (x position) (y position) 3)))))

(defsketch fireworks
    ((width 1400) (height 1000)
     (center-x (/ width 2)) (center-y (/ height 2))
     (speed 12) (xs 0.01)
     (particle-count 100)
     (particles (fill-particles center-x center-y particle-count))
     (gravity (make-vector 0 0.1)))
  (background +white+)
  (flet ((update-frame ()
           (dotimes (i particle-count)
             (accelerate (aref particles i) gravity)
             (update (aref particles i)))))
    (update-frame)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (iterate (for p in-vector particles)
               (with-slots (position) p
                 (circle (x position) (y position) 5))))))







