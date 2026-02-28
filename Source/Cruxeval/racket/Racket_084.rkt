#lang racket

(define (f text)
  (define arr (string-split text))
  (define result '())
  (for ([item arr])
    (if (string-suffix? item "day")
        (set! item (string-append item "y"))
        (set! item (string-append item "day")))
    (set! result (append result (list item))))
  (string-join result " "))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "nwv mef ofme bdryl") "nwvday mefday ofmeday bdrylday" 0.001)
))

(test-humaneval)
