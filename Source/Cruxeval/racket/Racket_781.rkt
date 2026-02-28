#lang racket

(define (f s ch)
  (define chs (string->list ch))
  (define sl (string->list s))
  (cond
    [(not (member chs sl)) ""]
    [else (list->string (reverse (cdr (member chs (reverse sl)))))]))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "shivajimonto6" "6") "" 0.001)
))

(test-humaneval)
