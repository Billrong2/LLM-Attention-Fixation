#lang racket

(define (f text)
  (list->string (filter (lambda (x) (not (equal? x #\) ))) (string->list text))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "(((((((((((d))))))))).))))(((((") "(((((((((((d.(((((" 0.001)
))

(test-humaneval)
