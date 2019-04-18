(in-package :coding-math)

(defclass vec ()
  ((x :initform 0.0 :initarg :x :accessor x)
   (y :initform 0.0 :initarg :y :accessor y)
   (len :initform 0.0 :initarg :len :accessor len)
   (angle :initform 0.0 :initarg :angle :accessor angle)))

(defun make-vector (x y)
  (let ((length (sqrt (+ (* x x) (* y y))))
        (angle (atan y x)))
    (make-instance 'vec :x x :y y :len length :angle angle)))

(defmethod print-object ((obj vec) stream)
  (print-unreadable-object (obj stream :type t)
    (with-slots (x y) obj
      (format stream "(~a, ~a)" x y))))

(defun (setf x) (new-value vec)
  (with-slots (x) vec
    (setf x new-value)))

(defun (setf y) (new-value vec)
  (with-slots (y) vec
    (setf y new-value)))

(defun (setf angle) (a vec)
  (with-slots (x y len angle) vec
    (setf angle a
          x (* len (cos a))
          y (* len (sin a)))))

(defun (setf len) (length vec)
  (with-slots (x y len angle) vec
      (setf len length
            x (* length (cos angle))
            y (* length (sin angle)))))

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

(defmethod v+= ((vec1 vec) (vec2 vec))
  (let ((new-v (v+ vec1 vec2)))
    (with-slots (x y len angle) new-v
      (setf (x vec1) x)
      (setf (y vec1) y)
      (setf (len vec1) len)
      (setf (angle vec1) angle))))

(defmethod v-= ((vec1 vec) (vec2 vec))
  (let ((new-v (v- vec1 vec2)))
    (with-slots (x y len angle) new-v
      (setf (x vec1) x)
      (setf (y vec1) y)
      (setf (len vec1) len)
      (setf (angle vec1) angle))))
