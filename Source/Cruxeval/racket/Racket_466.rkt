#lang racket

(define (f text)
  (define length (string-length text))
  (define index 0)
  (define (loop)
    (cond
      [(and (< index length) (char-whitespace? (string-ref text index)))
       (set! index (+ index 1))
       (loop)]
      [else (substring text index (+ index 5))]))
  (loop))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "-----	
	th
-----") "-----" 0.001)
))

(test-humaneval)
