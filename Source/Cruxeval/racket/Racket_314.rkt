#lang racket

(define (f text)
  (if (string-contains? text ",")
      (let* ((parts (string-split text ","))
             (before (first parts))
             (after (string-join (rest parts) ",")))
        (string-append after " " before))
      (string-append ", " (third (string-split text " ")) " 0")))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "244, 105, -90") " 105, -90 244" 0.001)
))

(test-humaneval)
