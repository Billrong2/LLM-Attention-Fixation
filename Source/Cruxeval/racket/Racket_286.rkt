#lang racket

(define (f array x i)
    (let* ((n (length array)))
      (cond
        [(or (< i (- 0 n)) (> i (- n 1))) 'no]
        [else
          (let* ((temp (list-ref array i))
                 (new-array (list-set array i x)))
            new-array)])))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3 4 5 6 7 8 9 10) 11 4) (list 1 2 3 4 11 6 7 8 9 10) 0.001)
))

(test-humaneval)
