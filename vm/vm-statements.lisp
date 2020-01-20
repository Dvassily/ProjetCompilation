(defun vm-statements ()
  '((halt . vm-halt)
    (push . vm-push)
    (move . vm-move)
    (jsr . vm-jsr)))

(defun find-statement (pc &key vm)
  (aref (cdr (assoc 'vm-memory vm)) pc))

(defun vm-halt (vm args)
  (rplacd (assoc 'vm-running vm) nil)
  nil)

(defun vm-push (vm args)
  (let ((src (car args)))
    (setf (aref (vm-memory vm) (vm-get-register vm 'SP)) (cadr src))
    (setf (aref (vm-registers vm) 4) (+ (vm-get-register vm 'SP) 1)))
  (+ (vm-get-register vm 'PC) 1))

(defun vm-move (vm args)
  (let ((src (car args))
	(dest (cadr args)))
    (setf (vm-get-register vm dest) (vm-get-register vm src)))
  (+ (vm-get-register vm 'PC)  1))

(defun vm-jsr (vm args)
  (let ((label (car args)))
    (vm-resolve-address vm label)))
