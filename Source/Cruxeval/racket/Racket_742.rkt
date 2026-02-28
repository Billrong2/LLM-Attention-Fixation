#lang racket

(define (f text)
  (define b #t)
  (let loop ((chars (string->list text)))
    (cond
      [(null? chars) b]
      [(char-numeric? (car chars)) (loop (cdr chars))]
      [else (set! b #f) #f])
    )
  )
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "-1-3") #f 0.001)
))

(test-humaneval)
