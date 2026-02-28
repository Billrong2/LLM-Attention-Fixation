#lang racket

(define (f r w)
    (define a '())
    (if (and (char=? (string-ref r 0) (string-ref w 0))
             (char=? (string-ref w (sub1 (string-length w))) (string-ref r (sub1 (string-length r)))))
        (begin
            (set! a (append a (list r)))
            (set! a (append a (list w)))
        )
        (begin
            (set! a (append a (list w)))
            (set! a (append a (list r)))
        )
    )
    a
)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ab" "xy") (list "xy" "ab") 0.001)
))

(test-humaneval)
