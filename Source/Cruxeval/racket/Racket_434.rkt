#lang racket

(define (f string)
  (if (string? string)
      (let loop ([i (sub1 (string-length string))])
        (cond
          [(negative? i) #f]
          [(char=? (string-ref string i) #\e) i]
          [else (loop (sub1 i))]))
      "Nuk"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "eeuseeeoehasa") 8 0.001)
))

(test-humaneval)
