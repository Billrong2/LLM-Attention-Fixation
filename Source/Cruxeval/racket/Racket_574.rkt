#lang racket

(define (f simpons)
  (let loop ([new-simpson (reverse simpons)])
    (if (empty? new-simpson)
        (first simpons)
        (if (equal? (string-titlecase (first new-simpson)) (first new-simpson))
            (first new-simpson)
            (loop (rest new-simpson))))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "George" "Michael" "George" "Costanza")) "Costanza" 0.001)
))

(test-humaneval)
