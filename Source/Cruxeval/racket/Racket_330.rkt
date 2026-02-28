#lang racket

(define (f text)
  (define ans '())
  (for ([char (in-string text)])
    (if (char-numeric? char)
        (set! ans (cons char ans))
        (set! ans (cons #\space ans))))
  (list->string (reverse ans)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "m4n2o") " 4 2 " 0.001)
))

(test-humaneval)
