#lang racket

(define (f url)
  (regexp-replace #rx"http://www." url ""))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "https://www.www.ekapusta.com/image/url") "https://www.www.ekapusta.com/image/url" 0.001)
))

(test-humaneval)
