#lang racket

(define (f item)
  (define modified (string-replace (string-replace (string-replace (string-replace item ". " " , ") "&#33; " "! ") ". " "? ") ". " ". "))
  (string-append (string-upcase (substring modified 0 1)) (substring modified 1)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate ".,,,,,. منبت") ".,,,,, , منبت" 0.001)
))

(test-humaneval)
