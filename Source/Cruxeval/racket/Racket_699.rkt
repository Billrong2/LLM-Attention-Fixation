#lang racket

(define (f text elem)
  (if (not (string=? elem ""))
      (begin
        (when (string-prefix? elem text)
          (set! text (string-replace text elem "")))
        (when (string-prefix? text elem)
          (set! elem (string-replace elem text ""))))
      (set! elem ""))
  (list elem text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "some" "1") (list "1" "some") 0.001)
))

(test-humaneval)
