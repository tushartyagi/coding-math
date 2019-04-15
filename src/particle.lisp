(in-package :coding-math)

(declaim (inline square))

(defun square (x)
  (* x x))

(defclass particle ()
  ((position :type vec :initarg :position :accessor pos)
   (velocity :type vec :initarg :velocity :accessor vel)
   (mass :initarg :mass :initform 1 :accessor mass)))

(defun particle-create (x y speed direction)
  (let ((position (make-vector x y))
        (velocity (make-vector 0 0)))
    (setf (angle velocity) direction)
    (setf (len velocity) speed)
    (make-instance 'particle :position position :velocity velocity)))

(defmethod print-object ((p particle) stream)
  (print-unreadable-object (p stream :type t)
    (with-slots (position velocity) p
      (format stream "(~a, ~a)  (~a, ~a)"
              (x position) (y position)
              (len velocity) (angle velocity)))))

(defmethod update ((p particle))
  (with-slots (position velocity) p
    (setf position (v+ position velocity))))

(defmethod accelerate ((p particle) (v vec))
  (with-slots (velocity) p
    (setf velocity (v+ v velocity))))

(defmethod particle-x ((p particle))
  (x (pos p)))

(defmethod particle-y ((p particle))
  (y (pos p)))

;; speed is locked and sbcl gives me warning
;; Just as well use struct instead of classes
(defmethod particle-speed ((p particle))
  (len (vel p)))

(defmethod particle-direction ((p particle))
  (angle (vel p)))

(defmethod angle-to ((p1 particle) (p2 particle))
  (let ((dx (- (particle-x p2) (particle-x p1)))
        (dy (- (particle-y p2) (particle-y p1))))
    (atan dy dx)))

(defmethod distance-to ((p1 particle) (p2 particle))
  (let ((dx (- (particle-x p2) (particle-x p1)))
        (dy (- (particle-y p2) (particle-y p1))))
    (sqrt (+ (square dx) (square dy)))))

(defmethod gravitate-to ((p1 particle) (p2 particle))
  (let* ((grav (make-vector 0 0))
         (dist (distance-to p1 p2)))
    (setf (len grav) (/ (mass p2) (square dist)))
    (setf (angle grav) (angle-to p1 p2))
    (v+= (vel p1) grav)))




