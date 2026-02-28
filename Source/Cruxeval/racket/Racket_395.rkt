#lang racket

(define (f s)
  (let loop ((i 0))
    (cond
      ((= i (string-length s)) -1)
      ((char-numeric? (string-ref s i))
       (+ i (if (char=? (string-ref s i) #\0) 1 0)))
      ((char=? (string-ref s i) #\0) -1)
      (else (loop (+ i 1))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "11") 0 0.001)
))

(test-humaneval)
