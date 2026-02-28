#lang racket

(define (f txt alpha)
  (set! txt (sort txt string<?))
  (if (= (modulo (index-of txt alpha) 2) 0)
      (reverse txt)
      txt))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "8" "9" "7" "4" "3" "2") "9") (list "2" "3" "4" "7" "8" "9") 0.001)
))

(test-humaneval)
