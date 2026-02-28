#lang racket

(define (f text suffix)
  (let loop ((output text))
    (cond
      [(string-suffix? suffix output)
       (loop (substring output 0 (- (string-length output) (string-length suffix))))]
      [else
       output])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "!klcd!ma:ri" "!") "!klcd!ma:ri" 0.001)
))

(test-humaneval)
