#lang racket

(define (f L)
  (define N (length L))
  (for ([k (in-range 1 (+ (/ N 2) 1))])
    (let loop ([i (- k 1)]
               [j (- N k)])
      (when (< i j)
        (let ([temp (list-ref L i)])
          (set! L (list-set L i (list-ref L j)))
          (set! L (list-set L j temp)))
        (loop (+ i 1) (- j 1)))))
  L)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 16 14 12 7 9 11)) (list 11 14 7 12 9 16) 0.001)
))

(test-humaneval)
