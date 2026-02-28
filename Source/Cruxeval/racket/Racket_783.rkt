#lang racket

(define (f text comparison)
  (define length (string-length comparison))
  (if (<= length (string-length text))
      (let loop ((i 0))
        (cond
          [(= i length) length]
          [(not (= (string-ref comparison (- length i 1)) (string-ref text (- (string-length text) i 1))))
           i]
          [else (loop (+ i 1))]))
      length))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "managed" "") 0 0.001)
))

(test-humaneval)
