#lang racket

(define (f text n)
  (if (<= (string-length text) 2)
      text
      (let* ((leading-chars (make-string (- n (string-length text) 1) (string-ref text 0)))
             (substring (substring text 1 (- (string-length text) 1))))
        (string-append leading-chars substring (substring text (- (string-length text) 1) (string-length text))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "g" 15) "g" 0.001)
))

(test-humaneval)
