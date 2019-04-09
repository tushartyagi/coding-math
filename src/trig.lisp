(in-package :coding-math)

(defsketch sine-wave
    ((width 800) (height 600))
  (background +white+)
  (with-pen (make-pen :fill +red+ :stroke +green+ :weight 1)
    (line 0 (/ height 2) width (/ height 2))
    (loop for i from 0 to (* 5 PI) by 0.01
       do (let ((x (* i 50))
                (y (* (sin i) 50)))
            (point x (+ (/ height 2) y))))))

(defsketch cosine-wave
    ((width 800) (height 600))
  (background +white+)
  (with-pen (make-pen :fill +red+ :stroke +green+ :weight 1)
    (line 0 (/ height 2) width (/ height 2))
    (loop for i from 0 to (* 5 PI) by 0.01
       do (let ((x (* i 50))
                (y (* (cos i) 50)))
            (point x (+ (/ height 2) y))))))

(defsketch tan-wave
    ((width 800) (height 600))
  (background +white+)
  (with-pen (make-pen :fill +red+ :stroke +green+ :weight 1)
    (line 0 (/ height 2) width (/ height 2))
    (loop for i from 0 to (* 5 PI) by 0.01
       do (let ((x (* i 50))
                (y (* (tan i) 50)))
            (point x (+ (/ height 2) y))))))


(defsketch moving-sine-wave
    ((width 800) (height 600)
     (dist 0))
  (background +white+)
  (incf dist)
  (with-pen (make-pen :fill +red+ :stroke +green+ :weight 1)
    (line 0 (/ height 2) width (/ height 2))
    (loop for i from 0 to (* 5 PI) by 0.01
       do (let ((x (* i 50))
                (y (* (sin i) 50)))
            (point (+ dist  x) (+ (/ height 2) y))))))

(defsketch jumping-circle
    ((width 800) (height 600)
     (center-x (* height 0.5))
     (center-y (* width  0.5))
     (offset   (* height 0.3))
     (speed 0.1)
     (angle 0))
  (background +white+)
  (incf angle speed)
  ;; -1 <= Sin angle <= 1
  ;; ∴ offset also lies between -1 and 1 and therefore
  ;; the actual position of y moves -1 to 1 units around
  ;; the center position.
  (let ((y (+ center-y (* offset (sin angle))))) 
    (with-pen (make-pen :fill +black+)
      ;; Since the y keeps on  changing with every tick, the circle
      ;; seems to be jumping.
      (circle center-x y 15))))

(defsketch growing-circle
    ((width 800) (height 600)
     (center-x (* height 0.5))
     (center-y (* width  0.5))
     (offset   (* height 0.3))
     (speed 0.01)
     (angle 0))
  (background +white+)
  (incf angle speed)
  ;; -1 <= Sin angle <= 1
  ;; ∴ offset also lies between -1 and 1 and therefore
  ;; the actual position of y moves -1 to 1 units around
  ;; the center position.
  (let ((radius (* offset (sin angle)))) 
    (with-pen (make-pen :fill +black+)
      ;; Since the y keeps on  changing with every tick, the circle
      ;; seems to be jumping.
      (circle center-x center-y radius))))

(defsketch rotating-circle
    ((width 800) (height 600)
     (center-x (* height 0.5))
     (center-y (* width  0.5))
     (radius 10)
     (speed 0.05)
     (angle 0))
  (background +white+)
  (incf angle speed)
  ;; As the circle needs to rotate around a fixed point, the sin and
  ;; the cosine angles are going to change. The x-axis is always
  ;; rCos(A) and y-axis is always rSin(A). If we can change these
  ;; values over time, the circle will be shown as rotating. 
  (let ((x (+ center-x (* 10 radius (cos angle))))
        (y (+ center-y (* 10 radius (sin angle)))))
    ;; Add a sun and make earth rotate around it.
    (with-pen (make-pen :fill +orange+)
      (circle center-x center-y 20))
    (with-pen (make-pen :fill +blue+ :stroke +green+)
      (circle x y (* 0.2 radius)))))
