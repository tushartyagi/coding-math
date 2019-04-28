(in-package :coding-math)

(with-sketch spring-with-dist
    ((spring-point (vector-create center-x center-y))
     (k 0.5)
     (spring-length 100)
     (weight (particle-create (random center-x) (random center-y)
                              50 (* 2 (random (* pi 2))) 10 10 0.9 0.5)))

  ;; Giving the spring an initial distance from which it is decompressed,
  ;; the force follows Hooke's law where F = -(k * distance)
  (let ((distance (v- spring-point (pos weight))))
    (setf (len distance) (- (len distance) spring-length))
    (let ((spring-force (v* distance k)))
      (with-pen (make-pen :fill +black+ :stroke +black+)
        (v+= (velocity weight) spring-force)
        (update weight)
        (circle (x spring-point) (y spring-point) 3)
        (line (x spring-point) (y spring-point) (x weight) (y weight))
        (circle (x weight) (y weight) (radius weight))))))


(defmethod kit.sdl2:mousemotion-event ((spring spring-with-dist)
                                       timestamp button-mask x y xrel yrel)
  (declare (ignore timestamp button-mask xrel yrel))
  (with-slots (spring-point) spring
    (setf (x spring-point) x
          (y spring-point) y)))


(with-sketch two-springs-with-dist
    ((pos1 (cons center-x center-y))
     (pos2 (cons (+ center-x 10) (+ center-y 10)))
     (spring-point-1 (vector-create (car pos1) (cdr pos2)))
     (spring-point-2 (vector-create (car pos2) (cdr pos2)))
     (k 0.5)
     (spring-length 100)
     (particle-1 (particle-create (random width) (random height) (random 50)
                                  (* 2 (random (* pi 2))) 20 10 0.9))
     (particle-2 (particle-create (random width) (random height) (random 50)
                                  (* 2 (random (* pi 2))) 20 10 0.9)))

  (flet ((springs (p0 p1 sep)
           (let ((distance (v- (pos p0) (pos p1))))
             (setf (len distance) (- (len distance) sep))
             (let ((spring-force (v* distance k)))
               (v+= (velocity p1) spring-force)
               (v-= (velocity p0) spring-force)))))
    (springs particle-1 particle-2 spring-length)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (update particle-1)
      (update particle-2)
      (circle (x particle-1) (y particle-1) (radius particle-1))
      (circle (x particle-2) (y particle-2) (radius particle-2))
      (line (x particle-1) (y particle-1) (x particle-2) (y particle-2)))))

(with-sketch three-springs-with-dist
    ((k 0.5)
     (spring-length 100)
     (particle-1 (particle-create (random width) (random height) (random 10)
                                  (* 2 (random (* pi 2))) 20 10 0.9))
     (particle-2 (particle-create (random width) (random height) (random 10)
                                  (* 2 (random (* pi 2))) 20 10 0.9))
     (particle-3 (particle-create (random width) (random height) (random 10)
                                  (* 2 (random (* pi 2))) 20 10 0.9)))

  (flet ((springs (p0 p1 sep)
           (let ((distance (v- (pos p0) (pos p1))))
             (setf (len distance) (- (len distance) sep))
             (let ((spring-force (v* distance k)))
               (v+= (velocity p1) spring-force)
               (v-= (velocity p0) spring-force)))))
    
    (springs particle-1 particle-2 spring-length)
    (springs particle-2 particle-3 spring-length)
    (springs particle-3 particle-1 spring-length)
    
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (update particle-1)
      (update particle-2)
      (update particle-3)
      (circle (x particle-1) (y particle-1) (radius particle-1))
      (circle (x particle-2) (y particle-2) (radius particle-2))
      (circle (x particle-3) (y particle-3) (radius particle-3))
      (line (x particle-1) (y particle-1) (x particle-2) (y particle-2))
      (line (x particle-2) (y particle-2) (x particle-3) (y particle-3))
      (line (x particle-1) (y particle-1) (x particle-3) (y particle-3)))))
