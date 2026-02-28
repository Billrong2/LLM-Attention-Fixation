#lang racket

(define (f text position value)
  (define length (string-length text))
  (define index
    (if (< position 0)
        (quotient length 2)
        (modulo position length)))
  (define new-text (string->list text))
  (set! new-text (insert-nth-item new-text index (string-ref value 0)))
  (set! new-text (remove-nth-item new-text (- length 1)))
  (list->string new-text))

(define (insert-nth-item lst index item)
  (append (take lst index)
          (list item)
          (drop lst index)))

(define (remove-nth-item lst index)
  (append (take lst index)
          (drop lst (+ index 1))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "sduyai" 1 "y") "syduyi" 0.001)
))

(test-humaneval)
