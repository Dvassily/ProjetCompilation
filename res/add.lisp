;; Source : 
;; (defun add(x y)
;;   (+ x y))
;; (add 1 2)

(defmacro sourceadd (inta intb)
  `((defun add(x y)
      (+ x y))
    (add ,inta ,intb)))


(defmacro codeadd (inta intb)
  `((push (:const ,inta))
    (push (:const ,intb))
    (move SP FP)
    (push (:const 2))
    (jsr add)
    (add (:const -2) FP)
    (add (:const -3) SP)
    (halt)
    (label add)
    (move (fp -2) R1)
    (move (fp -1) R0)
    (add R1 R0)
    (rtn)))
