(in-package :coding-math)

(with-sketch spring ((spring-point (vector-create center-x center-y))
                       (k 0.5)
                     (weight (particle-create (random center-x) (random center-y)
                                              50 (* 2 (random (* pi 2))) 10 10 0.9)))

  (let* ((distance (v- spring-point (pos weight)))
         (spring-force (v* distance k)))
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (v+= (velocity weight) spring-force)
      (update weight)
      (circle (x spring-point) (y spring-point) 3)
      (line (x spring-point) (y spring-point) (x weight) (y weight))
      (circle (x weight) (y weight) (radius weight)))))


(defmethod kit.sdl2:mousemotion-event ((spring spring)
                                       timestamp button-mask x y xrel yrel)
  (declare (ignore timestamp button-mask xrel yrel))
  (with-slots (spring-point) spring
    (setf (x spring-point) x
          (y spring-point) y)))


  
