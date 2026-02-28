#lang racket

(define (f text to_place)
  (define after_place (substring text 0 (add1 (string-length (substring text 0 (string-length to_place))))))
  (define before_place (substring text (add1 (string-length (substring text 0 (string-length to_place))))))
  (string-append after_place before_place))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "some text" "some") "some text" 0.001)
))

(test-humaneval)
