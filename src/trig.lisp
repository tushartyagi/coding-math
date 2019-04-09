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
     (speed 0.05)
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
