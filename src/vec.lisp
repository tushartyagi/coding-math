(in-package :coding-math)

(defclass vec ()
  ((x :initform 0.0 :initarg :x :accessor x)
   (y :initform 0.0 :initarg :y :accessor y)
   (len :initform 0.0 :initarg :len :accessor len)
   (angle :initform 0.0 :initarg :angle :accessor angle)))

(defun vector-create (x y)
  (let ((length (sqrt (+ (* x x) (* y y))))
        (angle (atan y x)))
    (make-instance 'vec :x x :y y :len length :angle angle)))

(defmethod print-object ((obj vec) stream)
  (print-unreadable-object (obj stream :type t)
    (with-slots (x y) obj
      (format stream "(~a, ~a)" x y))))

(defmethod (setf angle) (new-value (v vec))
  (with-slots (x y len angle) v
    (setf angle new-value
          x (* len (cos new-value))
          y (* len (sin new-value)))))

;; length is a locked symbol
(defmethod (setf len) (new-value (v vec))
  (with-slots (x y len angle) v
    (setf len new-value
          x (* new-value (cos angle))
          y (* new-value (sin angle)))))

;; '+ is locked in CL. TODO: Shadow and use it.
(defmethod v+ ((vec1 vec) (vec2 vec))
  (vector-create (+ (x vec1) (x vec2))
                 (+ (y vec1) (y vec2))))

(defmethod v- ((vec1 vec) (vec2 vec))
  (vector-create (- (x vec1) (x vec2))
                 (- (y vec1) (y vec2))))

(defmethod v* ((vec vec) (n number))
  (vector-create (* n (x vec))
                 (* n (y vec))))

(defmethod v/ ((vec vec) (n number))
  (vector-create (/ (x vec) n)
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
