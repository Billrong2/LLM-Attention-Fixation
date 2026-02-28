#lang racket

(define (f text)
    (define new-text (string->list text))
    (for/list ((i (in-range (length new-text))))
        (define character (list-ref new-text i))
        (define new-character (char-upcase character))
        (set! new-text (list-set new-text i new-character)))
    (list->string new-text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "dst vavf n dmv dfvm gamcu dgcvb.") "DST VAVF N DMV DFVM GAMCU DGCVB." 0.001)
))

(test-humaneval)
