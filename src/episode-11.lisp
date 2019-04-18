(in-package :coding-math)

(with-sketch solar-system ((sun (particle-create center-x center-y 0 0))
                           (planet (particle-create (+ center-x 200) center-y 8 (* -1 (/ Pi 2)))))

  (setf (mass sun) 20000)
  (gravitate-to planet sun)
  (update planet)

  (with-pen (make-pen :fill +yellow+ :stroke +orange+)
    (circle center-x center-y 20))

  (with-pen (make-pen :fill +green+ :stroke +green+)
    (circle (x planet) (y planet) 10)))
