#lang racket
(require racket/list)

(define (f length text)
  (if (= (string-length text) length)
      (reverse text)
      #f))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate -5 "G5ogb6f,c7e.EMm") #f 0.001)
))

(test-humaneval)
