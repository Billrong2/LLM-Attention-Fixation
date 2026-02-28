#lang racket

(define (f text)
  (let loop ((text text))
    (if (string-contains? text "nnet lloP")
        (loop (string-replace text "nnet lloP" "nnet loLp"))
        text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "a_A_b_B3 ") "a_A_b_B3 " 0.001)
))

(test-humaneval)
