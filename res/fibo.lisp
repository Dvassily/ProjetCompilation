(defun fibosource (n)
  `((defun fibo (x)
      (if (<= x 1)
	  x
	  (let ((a (fibo (- x 1)))
		(b (fibo (- x 2))))
	    (+ a b))))
    (fibo ,n)))

(defun fibo (x)
  (if (<= x 1)
      x
      (let ((a (fibo (- x 1)))
	    (b (fibo (- x 2))))
	(+ a b))))

(defun fibovm (n)
  `((push (:const ,n))
    (move FP R1)
    (move SP FP)
    (push (:const 1))
    (push R1)
    (jsr fibo)
    (pop FP)
    (add (:const -2) SP)
    (halt)
    (label fibo)
    (move (fp -1) R1)
    (cmp R1 (:const 1))
    (jle end)
    ;; begin : call (fibo (- n 1))
    (add (:const -1) R1)
    (push R1)
    (move FP R1)
    (move SP FP)
    (push (:const 1))
    (push R1)
    (jsr fibo)
    (pop FP)
    (add (:const -2) SP)
    ;; end : call (fibo (- n 1))
    (push R0)
    ;; begin : call (fibo (- n 2))
    (move (fp -1) R1)
    (add (:const -2) R1)
    (push R1)
    (move FP R1)
    (move SP FP)
    (push (:const 1))
    (push R1)
    (jsr fibo)
    (pop FP)
    (add (:const -2) SP)
    ;; end : call (fibo (- n 2))
    (pop R1)
    (add R1 R0)
    (rtn)
    (label end)
    (move R1 R0)
    (rtn)))
