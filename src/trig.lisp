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


