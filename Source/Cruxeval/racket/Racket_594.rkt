#lang racket

(define (f file)
  (let loop ([i 0])
    (cond
      [(= i (string-length file)) #f]
      [(char=? (string-ref file i) #\newline) i]
      [else (loop (+ i 1))])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "n wez szize lnson tilebi it 504n.
") 33 0.001)
))

(test-humaneval)
