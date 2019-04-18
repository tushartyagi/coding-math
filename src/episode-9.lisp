(in-package :coding-math)

(with-sketch fireworks ((particle-count 100)
                        (particles (fill-particles center-x center-y particle-count))
                        (gravity (vector-create 0 0.1)))
  (flet ((update-frame ()
           (dotimes (i particle-count)
             (accelerate (aref particles i) gravity)
             (update (aref particles i)))))
    (update-frame)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (iterate (for p in-vector particles)
               (with-slots (position) p
                 (circle (x position) (y position) 5))))))
