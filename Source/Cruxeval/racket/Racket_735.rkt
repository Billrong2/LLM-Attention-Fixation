#lang racket

(define (f sentence)
  (if (string=? sentence "")
      ""
      (let ([sentence (string-replace sentence "(" "")])
        (let ([sentence (string-replace sentence ")" "")])
          (string-titlecase (string-replace sentence " " ""))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "(A (b B))") "Abb" 0.001)
))

(test-humaneval)
