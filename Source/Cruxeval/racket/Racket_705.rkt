#lang racket

(define (f cities name)
  (cond
    [(string=? name "") cities]
    [(and name (not (string=? name "cities"))) '()]
    [else (map (lambda (city) (string-append name city)) cities)]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "Sydney" "Hong Kong" "Melbourne" "Sao Paolo" "Istanbul" "Boston") "Somewhere ") (list ) 0.001)
))

(test-humaneval)
