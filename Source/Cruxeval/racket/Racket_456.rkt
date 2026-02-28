#lang racket

(define (f s tab)
  (for/fold ([result ""])
           ([c (in-string s)])
    (if (char=? c #\tab)
        (string-append result (make-string tab #\space))
        (string-append result (string c)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Join us in Hungary" 4) "Join us in Hungary" 0.001)
))

(test-humaneval)
