(in-package :coding-math)

(with-sketch particle ((speed 12)
                       (xs 0.01)
                       (position (make-vector 10 10))
                       (velocity (make-vector 1 1)))
  (setf position (v+ position velocity))
  (with-pen (make-pen :fill +black+ :stroke +black+)
    (circle (x position) (y position) 10)))

(defun fill-particles (x y count)
  (let ((v (make-array count :fill-pointer t)))
    (dotimes (i count)
      (let ((m (particle-create x y
                                (+ (random 30) 2)
                                (* (random pi) 2))))
        (setf (aref v i) m)))
    v))

(with-sketch particles ((particle-count 100)
                        (particles (fill-particles center-x center-y particle-count)))
  (flet ((update ()
           (dotimes (i particle-count)
             (update (aref particles i)))))
    (update)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (iterate (for p in-vector particles)
               (with-slots (position) p
                 (circle (x position) (y position) 10))))))


(defsketch particles-without-macro
    ((width 800) (height 600)
     (center-x (/ width 2)) (center-y (/ height 2))
     (speed 12) (xs 0.01)
     (particle-count 100)
     (particles (fill-particles center-x center-y particle-count)))
  (background +white+)
  (flet ((update-frame ()
           (dotimes (i particle-count)
             (particle-update (aref particles i)))))
    (update-frame)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (iterate (for p in-vector particles)
               (with-slots (position) p
                 (circle (x position) (y position) 10))))))



