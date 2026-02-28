#lang racket

(define (string-pad-right str len char)
  (let ((str-len (string-length str)))
    (if (< str-len len)
        (string-append str (make-string (- len str-len) char))
        str)))

(define (f text limit char)
  (if (< limit (string-length text))
      (substring text 0 limit)
      (string-pad-right text limit char)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "tqzym" 5 "c") "tqzym" 0.001)
))

(test-humaneval)
