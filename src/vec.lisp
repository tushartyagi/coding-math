(in-package :coding-math)

(defclass vec ()
  ((x :initform 0.0 :initarg :x :accessor x)
   (y :initform 0.0 :initarg :y :accessor y)
   (r :initform 0.0 :initarg :r)
   (angle :initform 0.0 :initarg :angle)))

(defun make-vector (x y)
  (let ((length (sqrt (+ (* x x) (* y y))))
        (angle (atan y x)))
    (make-instance 'vec :x x :y y :r length :angle angle)))


(defmethod print-object ((obj vec) stream)
  (print-unreadable-object (obj stream :type t)
    (with-slots (x y) obj
      (format stream "(~a, ~a)" x y))))

;; '+ is locked in CL. TODO: Shadow and use it.
(defmethod v+ ((vec1 vec) (vec2 vec))
  (make-vector (+ (x vec1) (x vec2))
               (+ (y vec1) (y vec2))))

(defmethod v- ((vec1 vec) (vec2 vec))
  (make-vector (- (x vec1) (x vec2))
               (- (y vec1) (y vec2))))

(defmethod v* ((vec vec) (n number))
  (make-vector (* n (x vec))
               (* n (y vec))))

(defmethod v/ ((vec vec) (n number))
  (make-vector (/ (x vec) n)
               (/ (y vec) n)))
