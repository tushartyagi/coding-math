(in-package :coding-math)

(with-sketch flying-ship ((ship (particle-create center-x center-y 0 0))
                          (thrust (make-vector 0 0))
                          (angle 0))
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
        (ngon 3 (x position) (y position) 10 5 angle)))))

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

(with-sketch accelerating-ship ((ship (particle-create center-x center-y 0 0))
                          (thrust (make-vector 0 0))
                          (angle 0)
                          (turning-left nil)
                          (turning-right nil)
                          (thrusting nil))
  (flet ((check-borders ()
           (with-slots (position velocity) ship
             (with-slots (x y) position
               (cond ((> x width) (setf x 0))
                     ((< x 0) (setf x width))
                     ((> y height) (setf y 0))
                     ((< y 0) (setf y height))))))
         (update-frame ()
           (with-slots (position) ship
             (with-slots (x y) position
               (translate x y)
               (rotate angle)))
           (cond (turning-left  (setf angle (- angle 1.5)))
                 (turning-right (setf angle (+ angle 1.5))))
           (setf (angle thrust) angle)
           (setf (len thrust) (if thrusting 0.1 0))))
    (check-borders)
    (update-frame)
    (with-pen (make-pen :fill +black+ :stroke +black+)
      (accelerate ship thrust)
      (update ship)
      (line 0 7 20 0)
      (line 0 7 0 -7)
      (line 0 -7 20 0))))

(defmethod kit.sdl2:keyboard-event ((window accelerating-ship) state timestamp repeat-p keysym)
  (declare (ignore timestamp repeat-p))
  (with-slots (thrust thrusting turning-left turning-right) window
      (with-slots (x y) thrust
        (when (eql state :keydown)
          (cond 
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-up)
             (setf thrusting t))
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-left)
             (setf turning-left t))
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-right)
             (setf turning-right t))))

        (when (eql state :keyup)
          (cond 
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-up)
             (setf thrusting nil))
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-left)
             (setf turning-left nil))
            ((sdl2:scancode= (sdl2:scancode-value keysym) :scancode-right)
             (setf turning-right nil)))))))
