#lang racket

(define (f num)
    (cond 
        [(and (> num 0) (< num 1000) (not (= num 6174))) "Half Life"]
        [else "Not found"]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 6173) "Not found" 0.001)
))

(test-humaneval)
