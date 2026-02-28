#lang racket

(define (f text chars)
  (define num_applies 2)
  (define extra_chars "")
  
  (for ([i (in-range num_applies)])
    (set! extra_chars (string-append extra_chars chars))
    (set! text (string-replace text extra_chars "")))
  
  text)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "zbzquiuqnmfkx" "mk") "zbzquiuqnmfkx" 0.001)
))

(test-humaneval)
