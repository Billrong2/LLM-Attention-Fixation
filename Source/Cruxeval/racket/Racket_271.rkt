#lang racket

(define (f text c)
  (define ls (string->list text))
  (if (not (string-contains? text c))
      (raise '(ValueError "Text has no {c}"))
      (set! ls (remove (string-ref text (sub1 (string-length text))) ls)))
  (list->string ls))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "uufhl" "l") "uufh" 0.001)
))

(test-humaneval)
