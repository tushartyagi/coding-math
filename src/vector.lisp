(in-package :coding-math)

(iter (for i from 0 to (sin (* 2 PI)) by 0.01)
      (collect i))

(defsketch intro
    ((width 800) (height 600))
  (background +white+)
  (dotimes (i 100)
    (line (random width) (random height) (random width) (random height))))

(defsketch intro
    ((width 800) (height 600))
  (background +white+)
  (with-pen (make-pen :fill +red+ :stroke +yellow+ :weight 5)
    (line 0 0 25 25)
    (circle 25 25 25)))






(defsketch tutorial ()
  (rect 100 100 100 100))



(defsketch tutorial ()
  (dotimes (i 10)
    (rect (* i 40) (* i 40) 40 40 )))

(defsketch tutorial ()
  (line 0 0 10 10)
  (line 80 80 50 50))

(defsketch tutorial ()
  (polyline 10 10 40 40 50 50 100 100 50 50 30 30 20 20))

(defsketch tutorial ()
  (polyline 100 100 200 150 300 100
            200 200 100 100))

(defsketch tutorial ()
  (background +yellow+)
  (bezier 0 400 100 100 300 100 400 400))

(defsketch pen-test ((title "Tushar"))
  (with-pen (make-pen :fill +red+)
    (rect 0 0 100 100))
  (with-pen (make-pen :fill +yellow+)
    (circle 200 200 50)))


(defsketch tutorial ()
  (dotimes (i 4)
    (ngon (+ i 3) (+ 50 (* i 100)) 200 20 20 (* i 20))))

(defsketch sinewave
    ((title "Sinewave") (width 400) (height 400)
     (steps 0) (xs (/ width 5)) (r 3.5))
  (incf steps)
  (background (rgb 0.2 1.0 1.0))
  
  (let ((w width) (h height))
    (flet ((sin-calc (x)
	     (sin (* +tau+ (/ (+ (/ steps 4) x) xs)))))
      (dotimes (x xs)
	(with-pen(make-pen :fill +red+
			   :stroke (gray 0.1))
	  (ngon 6 (* x (/ w xs)) (+ (/ h 2) (* (/ h 4) (sin-calc x))) r r)
	  ;;(ngon 6 (* x (/ w xs)) (+ (/ h 2) (* (/ h 4) (sin-calc (- x)))) r r)
	  ;;(ngon 6 (* x (/ w xs)) (+ (/ h 2) (* (/ h 4) (- (sin-calc (- x))))) r r)
          ;;(ngon 6 (* x (/ w xs)) (+ (/ h 2) (* (/ h 4) (- (sin-calc x)))) r r)
          )))))

(defsketch snake
    ((title "snake") (width 400) (height 400)
     (steps 0) (xs (/ width 5)) (r 3))
  (incf steps)
  (let ((w width) (h height))
    (dotimes (x xs)
      (with-pen (make-pen :fill +red+)
        (circle x (/ h 2) 3)))))
