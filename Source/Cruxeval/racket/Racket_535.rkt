#lang racket

(define (f n)
    (let loop ((num (number->string n)))
        (cond
            [(string=? num "") #t]
            [(or (not (or (equal? (string-ref num 0) #\0) (equal? (string-ref num 0) #\1) (equal? (string-ref num 0) #\2)))
                 (not (member (string->number (string (string-ref num 0))) (range 5 10))))
             #f]
            [else (loop (substring num 1))])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 1341240312) #f 0.001)
))

(test-humaneval)
