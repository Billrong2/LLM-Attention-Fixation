#lang racket

(define (f text sep maxsplit)
  (let* ((splitted (regexp-split (regexp sep) text))
         (length (length splitted))
         (new-splitted (append (reverse (take splitted (quotient length 2)))
                               (drop splitted (quotient length 2)))))
    (string-join new-splitted sep)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ertubwi" "p" 5) "ertubwi" 0.001)
))

(test-humaneval)
