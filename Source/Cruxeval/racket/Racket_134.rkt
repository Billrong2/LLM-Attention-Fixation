#lang racket

(define (f n)
  (define t 0)
  (define b "")
  (define digits (map (lambda (c) (- (char->integer c) (char->integer #\0))) (string->list (number->string n))))
  (for ([d (in-list digits)]
        #:break (not (= d 0)))
    (set! t (+ t 1)))
  (for ([_ (in-range t)])
    (set! b (string-append b "104")))
  (set! b (string-append b (number->string n)))
  b)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 372359) "372359" 0.001)
))

(test-humaneval)
