#lang racket

(define (f text)
  (define new-text (string->list text))
  (for ([i (in-list '(+))])
    (when (member i new-text)
      (set! new-text (remove i new-text))))
  (list->string new-text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "hbtofdeiequ") "hbtofdeiequ" 0.001)
))

(test-humaneval)
