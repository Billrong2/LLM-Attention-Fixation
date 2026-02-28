#lang racket

(define (f row)
  (let ([count-1 (count-occurence-of-char row #\1)]
        [count-0 (count-occurence-of-char row #\0)])
    (list count-1 count-0)))

(define (count-occurence-of-char str char)
  (for/fold ([count 0]) ([c (in-string str)])
    (if (char=? c char)
        (add1 count)
        count)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "100010010") (list 3 6) 0.001)
))

(test-humaneval)
