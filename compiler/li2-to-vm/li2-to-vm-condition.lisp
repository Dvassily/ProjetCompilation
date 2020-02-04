					;TODO: Create make-statements

(defun compile-condition (comparison then else args-env locals-env compiler)
  (let ((then-label (compiler-increment-label-counter compiler))
	(end-label (compiler-increment-label-counter compiler)))
  (append (compile-comparison (car comparison) (cadr comparison) (caddr comparison) then-label args-env locals-env compiler)
	  (li2-to-vm-compile-expr else args-env locals-env compiler)
	  (list (list 'jmp end-label))
	  (list (list 'label then-label))
	  (li2-to-vm-compile-expr then args-env locals-env compiler)
	  (list(list 'label end-label)))))

(defun comparison-operator (operator)
  (assoc operator '((:lt . jlt)
		    (:le . jle)
		    (:eq . jeq)
		    (:ge . jge)
		    (:gt . jgt))))

(defun is-comparison (expr)
  (if (comparison-operator (car expr)) t nil))

(defun compile-comparison (operator first-operand second-operand then-label args-env locals-env compiler)
  (append (li2-to-vm-compile-expr first-operand args-env locals-env compiler)
	  (list (list 'move 'R0 'R1))
	  (li2-to-vm-compile-expr second-operand args-env locals-env compiler)
	  (list (list 'cmp 'R1 'R0))
	  (list (list (cdr (comparison-operator operator)) then-label))))

;; (compile-comparison :eq '(:const 1) '(:arg x) '(x) nil nil)
