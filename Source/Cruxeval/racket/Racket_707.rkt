#lang racket

(define (f text position)
  (define length (string-length text))
  (define index (modulo position (add1 length)))
  (define new-text (string->list text))
  (when (or (< position 0) (< index 0))
    (set! index -1))
  (set! new-text (remove-nth new-text index))
  (list->string new-text))
  
(define (remove-nth lst n)
  (cond [(= n 0) (rest lst)]
        [else (cons (first lst) (remove-nth (rest lst) (sub1 n)))]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "undbs l" 1) "udbs l" 0.001)
))

(test-humaneval)
