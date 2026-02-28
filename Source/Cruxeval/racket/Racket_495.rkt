#lang racket

(define (f s)
  (define (ascii? s)
    (for/and ([c (in-string s)])
      (<= (char->integer c) #x7F)))
  (let* ([last5 (substring s (- (string-length s) 5))]
         [first5 (substring s 0 5)])
    (cond
      [(ascii? last5) (list last5 (substring first5 0 3))]
      [(ascii? first5) (list first5 (substring last5 3))]
      [else s])))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "a1234år") (list "a1234" "år") 0.001)
))

(test-humaneval)
