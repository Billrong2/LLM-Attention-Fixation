#lang racket

(define (f text)
  (let* ((length (string-length text))
         (half (quotient length 2))
         (encode (string->bytes/utf-8 (substring text 0 half))))
    (if (equal? (substring text half) (bytes->string/utf-8 encode))
        #t
        #f)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "bbbbr") #f 0.001)
))

(test-humaneval)
