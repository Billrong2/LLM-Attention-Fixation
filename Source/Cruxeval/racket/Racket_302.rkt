#lang racket

(define (f string)
    (string-replace string "needles" "haystacks"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "wdeejjjzsjsjjsxjjneddaddddddefsfd") "wdeejjjzsjsjjsxjjneddaddddddefsfd" 0.001)
))

(test-humaneval)
