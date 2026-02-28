#lang racket

(define (f first second)
  (if (or (< (length first) 10) (< (length second) 10))
      "no"
      (let loop ((i 0))
        (cond
          [(= i 5) (append first second)]
          [(not (= (list-ref first i) (list-ref second i))) "no"]
          [else (loop (+ i 1))]))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 1) (list 1 1 2)) "no" 0.001)
))

(test-humaneval)
