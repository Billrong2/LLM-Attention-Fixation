#lang racket

(define (f phrase)
  (define result "")
  (for ([i (in-string phrase)])
    (unless (char-lower-case? i)
      (set! result (string-append result (string i)))))
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "serjgpoDFdbcA.") "DFA." 0.001)
))

(test-humaneval)
