#lang racket

(define (f text1 text2)
  (define nums '())
  (for ([i (in-range (string-length text2))])
    (set! nums (cons (count-occurences (string-ref text2 i) text1) nums)))
  (apply + nums))

(define (count-occurences char str)
  (count (λ (x) (eq? x char)) (string->list str)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "jivespdcxc" "sx") 2 0.001)
))

(test-humaneval)
