(in-package :coding-math)

(defclass particle ()
  ((position :type vec :initarg :position)
   (velocity :type vec :initarg :velocity)))

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
