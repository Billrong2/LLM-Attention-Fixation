#lang racket

(define (f phrase)
  (define ans 0)
  (for ([w (string-split phrase)])
    (for ([ch (in-string w)])
      (when (equal? ch #\0)
        (set! ans (+ ans 1)))))
  ans)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "aboba 212 has 0 digits") 1 0.001)
))

(test-humaneval)
