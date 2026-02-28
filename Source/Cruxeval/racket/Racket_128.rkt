#lang racket

(define (f text)
  (define odd "")
  (define even "")
  (for ([i (in-naturals)]
        [c (in-string text)])
    (if (= (remainder i 2) 0)
        (set! even (string-append even (string c)))
        (set! odd (string-append odd (string c))))
    )
  (string-append even (string-downcase odd)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Mammoth") "Mmohamt" 0.001)
))

(test-humaneval)
