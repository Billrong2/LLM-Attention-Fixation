#lang racket

(define (f text value)
  (define indexes '())
  (for ([i (in-range (string-length text))])
    (when (equal? (string-ref text i) (string-ref value 0))
      (set! indexes (cons i indexes))))
  (define new-text (string->list text))
  (for ([i (in-list indexes)])
    (set! new-text (remove (string-ref value 0) new-text)))
  (list->string new-text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "scedvtvotkwqfoqn" "o") "scedvtvtkwqfqn" 0.001)
))

(test-humaneval)
