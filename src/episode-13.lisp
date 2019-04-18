(in-package :coding-math)

(with-sketch friction ((p (particle-create center-x center-y 10 (* (random 1.0) pi 2)))
                       (friction (make-vector 0.15 0.0)))

  (setf (angle friction) (angle (particle-velocity p)))

  (if (> (len (particle-velocity p)) (len friction))
      (v-= (particle-velocity p) friction)
      (setf (len (particle-velocity p)) 0))

  (with-pen (make-pen :fill +black+ :stroke +black+)
    (update p)
    (circle (particle-x p) (particle-y p) 5)))
