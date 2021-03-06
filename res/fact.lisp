(defun factsource (n)
  `((defun fact (x)
      (if (= x 1)
	  1
	  (let ((y (fact (- x 1))))
	    (* x y))))
    (fact ,n)))

(defun fact (x)
  (if (= x 1)
      1
      (* x (fact (- x 1)))))

(defun factvm (n)
  `((push (:const ,n))
    (move FP R1)
    (move SP FP)
    (push (:const 1))
    (push R1)
    (jsr fact)
    (pop FP)
    (add (:const -2) SP)
    (halt)
    (label fact)
    (move (fp -1) R1)
    (cmp R1 (:const 1))
    (jeq end)
    (push R1)
    (add (:const -1) R1)
    (push R1)
    (move FP R1)
    (move SP FP)
    (push (:const 1))
    (push R1)
    (jsr fact)
    (pop FP)
    (add (:const -2) SP)
    (pop R1)
    (mul R1 R0)
    (rtn)
    (label end)
    (move (:const 1) R0)
    (rtn)))


