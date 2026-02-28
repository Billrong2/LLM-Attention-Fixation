#lang racket

(define (f text)
  (define res (regexp-split #rx"\\|" text))
  (define topic (list-ref res 0))
  (define problem (if (and (> (length res) 2) (equal? (list-ref res 2) "r")) 
                     (regexp-replace* #rx"u" topic "p")
                     (if (> (length res) 1)
                         (list-ref res 1)
                         "")))
  (list topic problem))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "|xduaisf") (list "" "xduaisf") 0.001)
))

(test-humaneval)
