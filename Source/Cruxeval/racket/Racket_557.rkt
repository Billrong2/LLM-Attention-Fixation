#lang racket

(define (f s)
  (define d (regexp-match #rx"^(.*)(ar)(.*)$" s))
  (if d
      (string-join (list (list-ref d 1) (list-ref d 2) (list-ref d 3)))
      ""))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "xxxarmmarxx") "xxxarmm ar xx" 0.001)
))

(test-humaneval)
