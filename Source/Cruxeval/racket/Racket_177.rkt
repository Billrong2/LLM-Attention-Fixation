#lang racket

(define (f text)
  (define text-list (string->list text))
  (for ([i (in-range (length text-list))])
    (when (odd? i)
      (set! text-list (list-update text-list i (lambda (x) (if (char-lower-case? x) (char-upcase x) (char-downcase x)))))))
  (list->string text-list))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Hey DUdE THis $nd^ &*&this@#") "HEy Dude tHIs $Nd^ &*&tHiS@#" 0.001)
))

(test-humaneval)
