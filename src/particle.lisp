(in-package :coding-math)

(declaim (inline square))

(defun square (x)
  (* x x))

(defclass particle ()
  ((position :type vec :initarg :position :accessor pos)
   (velocity :type vec :initarg :velocity :accessor velocity)
   (mass :initarg :mass :initform 1.0 :accessor mass)
   (radius :initarg :radius :initform 0.0 :accessor radius)
   (gravity :initarg :gravity :initform  0.0 :accessor gravity)
   (bounce :initarg :bounce :initform 1 :accessor bounce)
   (friction :initarg :friction :initform 0 :accessor friction)))

(defmethod print-object ((p particle) stream)
  (print-unreadable-object (p stream :type t)
    (with-slots (position velocity) p
      (format stream "(~a, ~a)  (~a, ~a)"
              (x position) (y position)
              (len velocity) (angle velocity)))))

(defun particle-create (x y speed direction &optional (radius 0.0) (mass 1.0) (friction 0) (gravity 0))
  (let ((position (vector-create x y))
        (velocity (vector-create 0 0))
        (gravity (vector-create 0 gravity)))
    (setf (angle velocity) direction)
    (setf (len velocity) speed)
    (make-instance 'particle :position position
                   :velocity velocity :radius radius :mass mass :friction friction :gravity gravity)))

(defmethod update ((p particle))
  (with-slots (position velocity friction gravity) p
    (setf velocity (v* velocity friction))
    (setf position (v+ position velocity))
    (setf velocity (v+ velocity gravity))))

(defmethod accelerate ((p particle) (v vec))
  (with-slots (velocity) p
    (setf velocity (v+ v velocity))))

(defmethod x ((p particle))
  (x (pos p)))

(defmethod (setf x) (new-value (p particle))
  (setf (x (pos p)) new-value))

(defmethod y ((p particle))
  (y (pos p)))

(defmethod (setf y) (new-value (p particle))
  (setf (y (pos p)) new-value))

(defmethod (setf velocity) (new-value (p particle))
  (declare (type vec new-value))
  (setf (velocity p) new-value))

;; speed is locked (it's used with optimize) and sbcl gives me warning
;; Could've just used struct instead of classes
(defmethod particle-speed ((p particle))
  (len (velocity p)))

(defmethod (setf particle-speed) (new-value (p particle))
  (with-slots (velocity) p
    (setf (len velocity) new-value)))

(defmethod direction ((p particle))
  (angle (velocity p)))

(defmethod (setf direction) (new-value (p particle))
  (with-slots (velocity) p
    (setf (angle velocity) new-value)))

(defmethod angle-to ((p1 particle) (p2 particle))
  (let ((dx (- (x p2) (x p1)))
        (dy (- (y p2) (y p1))))
    (atan dy dx)))

(defmethod distance-to ((p1 particle) (p2 particle))
  (let ((dx (- (x p2) (x p1)))
        (dy (- (y p2) (y p1))))
    (sqrt (+ (square dx) (square dy)))))

(defmethod gravitate-to ((p1 particle) (p2 particle))
  (let* ((grav (vector-create 0 0))
         (dist (distance-to p1 p2)))
    (setf (len grav) (/ (mass p2) (square dist)))
    (setf (angle grav) (angle-to p1 p2))
    (v+= (velocity p1) grav)))
