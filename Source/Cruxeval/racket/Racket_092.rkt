#lang racket

(define (f text)
  (for/and ([ch (in-string text)])
    (<= 0 (char->integer ch) 127)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "wW의IV]HDJjhgK[dGIUlVO@Ess$coZkBqu[Ct") #f 0.001)
))

(test-humaneval)
