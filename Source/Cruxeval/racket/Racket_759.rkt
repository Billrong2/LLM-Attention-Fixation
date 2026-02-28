#lang racket

(define (f text sub)
  (define index '())
  (define starting 0)
  (let loop ()
    (let ([pos (regexp-match-positions (regexp-quote sub) text starting)])
      (if pos
          (let ([start (caar pos)])
            (set! index (append index (list start)))
            (set! starting (+ start (string-length sub)))
            (loop))
          index))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "egmdartoa" "good") (list ) 0.001)
))

(test-humaneval)
