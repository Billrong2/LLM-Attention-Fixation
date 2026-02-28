#lang racket

(define (f text)
  (define count 0)
  (for ([i (in-string text)])
    (when (member i '(#\space #\. #\! #\? #\, #\.))
      (set! count (+ count 1))))
  count)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "bwiajegrwjd??djoda,?") 4 0.001)
))

(test-humaneval)
