#lang racket

(define (f values item1 item2)
    (cond
        [(= (last values) item2)
         (if (not (member (first values) (rest values)))
             (append values (list (first values)))
             values)]
        [(= (last values) item1)
         (if (= (first values) item2)
             (append values (list (first values)))
             values)
        ]
        [else values]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 1) 2 3) (list 1 1) 0.001)
))

(test-humaneval)
