#lang racket

(define (f)
    (define d
        (hash
            "Russia" (list (list "Moscow" "Russia") (list "Vladivostok" "Russia"))
            "Kazakhstan" (list (list "Astana" "Kazakhstan"))))
    (hash-keys d))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate ) (list "Russia" "Kazakhstan") 0.001)
))

(test-humaneval)
