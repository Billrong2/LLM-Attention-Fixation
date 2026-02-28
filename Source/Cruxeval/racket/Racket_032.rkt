#lang racket

(define (f s sep)
    (let* ((split (string-split s sep))
           (add-star (map (lambda (e) (string-append "*" e)) split))
           (reverse (reverse add-star))
           (join (apply string-append (add-between reverse ";") )))
        join))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "volume" "l") "*ume;*vo" 0.001)
))

(test-humaneval)
