#lang racket

(define (f st)
  (define swapped "")
  (for ([ch (in-list (reverse (string->list st)))])
    (set! swapped (string-append swapped (string (if (char-lower-case? ch)
                                                      (char-upcase ch)
                                                      (char-downcase ch))))))
  swapped)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "RTiGM") "mgItr" 0.001)
))

(test-humaneval)
