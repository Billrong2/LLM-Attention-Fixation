#lang racket

(define (string-pad-left str len)
  (let* ((str-len (string-length str))
         (pad-len (- len str-len)))
    (if (positive? pad-len)
        (string-append (make-string pad-len #\0) str)
        str)))

(define (f string numbers)
  (define arr
    (for/list ([num (in-list numbers)])
      (string-pad-left string num)))
  (string-join arr " "))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "4327" (list 2 8 9 2 7 1)) "4327 00004327 000004327 4327 0004327 4327" 0.001)
))

(test-humaneval)
