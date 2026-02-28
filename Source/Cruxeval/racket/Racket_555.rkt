#lang racket

(define (f text tabstop)
  (let* ((new-text (string-replace text "\n" "_____"))
         (new-text (string-replace new-text "\t" (make-string tabstop #\space)))
         (new-text (string-replace new-text "_____" "\n")))
    new-text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "odes	code	well" 2) "odes  code  well" 0.001)
))

(test-humaneval)
