(in-package :coding-math)

(with-sketch accelerating-particle ((p (particle-create 10 height 10 (* -1 (/ PI 2))))
                          (accel (make-vector 0.1 0.1)))
  (flet ((update ()
           (accelerate p accel)
           (update p)))
    (update)
    (with-pen (make-pen :fill +red+ :stroke +black+)
      (with-slots (position) p
        (circle (x position) (y position) 3)))))

(defsketch fireworks
    ((width 1400) (height 1000)
     (center-x (/ width 2)) (center-y (/ height 2))
     (speed 12) (xs 0.01)
     (particle-count 100)
     (particles (fill-particles center-x center-y particle-count))
     (gravity (make-vector 0 0.1)))
  (background +white+)
  (flet ((update-frame ()
           (dotimes (i particle-count)
             (accelerate (aref particles i) gravity)
             (update (aref particles i)))))
    (update-frame)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (iterate (for p in-vector particles)
               (with-slots (position) p
                 (circle (x position) (y position) 5))))))


(with-sketch fireworks ((particle-count 100)
                        (particles (fill-particles center-x center-y particle-count))
                        (gravity (make-vector 0 0.1)))
  (flet ((update-frame ()
           (dotimes (i particle-count)
             (accelerate (aref particles i) gravity)
             (update (aref particles i)))))
    (update-frame)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (iterate (for p in-vector particles)
               (with-slots (position) p
                 (circle (x position) (y position) 5))))))

(with-sketch flying-ship ((ship (particle-create center-x center-y 0 0))
                          (thrust (make-vector 0 0)))
  (flet ((check-borders ()
           (with-slots (position velocity) ship
             (with-slots (x y) position
               (cond ((> x width) (setf x 0))
                     ((< x 0) (setf x width))
                     ((> y height) (setf y 0))
                     ((< y 0) (setf y height)))))))
    (check-borders)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (accelerate ship thrust)
      (update ship)
      (with-slots (position velocity) ship
        (circle (x position) (y position) 5)))))

(defmethod kit.sdl2:keyboard-event ((window flying-ship) state timestamp repeat-p keysym)
  (with-slots (thrust) window
      (with-slots (x y) thrust
        (when (eql state :keydown)
          (cond 
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-up)
             (setf y (- y 0.1)))
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-down)
             (setf y (+ y 0.1)))
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-left)
             (setf x (- x 0.1)))
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-right)
             (setf x (+ x 0.1)))))

        (when (eql state :keyup)
          (cond 
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-up)
             (setf y 0))
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-down)
             (setf y 0))
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-left)
             (setf x 0))
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-right)
             (setf x 0)))))))



