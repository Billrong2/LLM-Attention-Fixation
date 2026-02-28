#lang racket

(define (f text)
  (define words (string-split text " "))
  (for/fold ([result "yes"])
            ([word (in-list words)])
    (if (string->number word)
        result
        "no")))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "03625163633 d") "no" 0.001)
))

(test-humaneval)
