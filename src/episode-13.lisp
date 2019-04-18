(in-package :coding-math)

(with-sketch friction ((p (particle-create center-x center-y 10 (* (random 1.0) pi 2)))
                       (friction (vector-create 0.15 0.0)))

  (setf (angle friction) (angle (velocity p)))

  (if (> (len (velocity p)) (len friction))
      (v-= (velocity p) friction)
      (setf (len (velocity p)) 0))

  (with-pen (make-pen :fill +black+ :stroke +black+)
    (update p)
    (circle (x p) (y p) 5)))
