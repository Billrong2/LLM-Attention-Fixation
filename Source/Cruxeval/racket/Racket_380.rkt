#lang racket

(define (f text delimiter)
  (let* ((splitted (regexp-split delimiter text))
        (first-part (string-join (take splitted (- (length splitted) 1)) delimiter))
        (last-part (last splitted)))
    (string-append first-part last-part)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "xxjarczx" "x") "xxjarcz" 0.001)
))

(test-humaneval)
