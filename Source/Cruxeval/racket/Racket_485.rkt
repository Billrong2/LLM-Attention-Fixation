#lang racket

(define (string-pad-right str len)
  (let ((str-len (string-length str)))
    (if (< str-len len)
        (string-append str (make-string (- len str-len) #\space))
        str)))

(define (f tokens)
  (define tokens-list (string-split tokens))
  (when (= (length tokens-list) 2)
    (set! tokens-list (reverse tokens-list)))
  (string-join (map (lambda (token) (string-pad-right token 5)) tokens-list) " "))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "gsd avdropj") "avdropj gsd  " 0.001)
))

(test-humaneval)
