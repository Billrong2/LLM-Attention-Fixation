#lang racket

(define (f text)
  (define words (string-split text))
  (for ([item words])
    (set! text (string-replace text (format "-~a" item) " ") )
    (set! text (string-replace text (format "~a-" item) " ") )
  )
  (string-trim text "-")
)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "-stew---corn-and-beans-in soup-.-") "stew---corn-and-beans-in soup-." 0.001)
))

(test-humaneval)
