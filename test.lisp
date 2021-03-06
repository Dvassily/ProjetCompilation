;; (require 'codecompute "./res/compute.lisp")
(require 'fact "./res/fact.lisp")
(require 'fact "./res/fibo.lisp")
(require 'init "./init.lisp")

(defun test-compile-run (basecode)
  (let ((code (compile-code basecode)))
    (print "Code : ")
    (print code)
    (test-run code)))

(defun test-run (code)
  (let ((vm (make-vm :memory-size 1000)))
    (vm-load code :vm vm)
    (let ((result (vm-run :main nil :vm vm)))
      (print "Result : ")
      (print result))))

(defun compile-run-fact (n)
  (format t "~%factorial(~D) : " n)
  (test-compile-run (factsource n)))

(defun compile-run-fibo (n)
  (format t "~%fibonacci(~D) : " n)
  (test-compile-run (fibosource n)))

;; (compile-run-fact 100)
;; (compile-run-fibo 10)

;; (test-compile-run (fibosource 10))


;; (test-run (fibovm 4))

;; (compile-li1-to-li2 (compile-cl-to-li1 (factsource 10)))

;; (compile-cl-to-li1 (factsource 10))

;; ;; (test-compile-run '((defun add(x y) (+ x y)) (add 5 3)))
;; ;; (test-run (factvm 10))
;; ;; (test-compile-run (compute-code 'add-op 1 2))

;; 815915283247897734345611269596115894272000000000
;; 815915283247897734345611269596115894272000000000 
