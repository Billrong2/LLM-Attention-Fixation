#lang racket

(define (f text)
  (for ([space (in-string text)])
    (if (char=? space #\space)
        (set! text (string-trim text))
        (set! text (string-replace text "cd" (string space)))))
  text)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "lorem ipsum") "lorem ipsum" 0.001)
))

(test-humaneval)
