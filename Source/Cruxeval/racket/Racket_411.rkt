#lang racket

(define (f text pref)
  (if (list? pref)
      (string-join (map (lambda (x) (string=? (substring text 0 (string-length x)) x)) pref) ", ")
      (string=? (substring text 0 (string-length pref)) pref)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Hello World" "W") #f 0.001)
))

(test-humaneval)
