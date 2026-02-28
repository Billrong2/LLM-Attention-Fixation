#lang racket

(define (f text)
  (define new-text '())
  (for ([character (in-string text)])
    (if (char-upper-case? character)
        (set! new-text (append (take new-text (quotient (length new-text) 2))
                               (list character)
                               (drop new-text (quotient (length new-text) 2))))
        new-text))
  (if (zero? (length new-text))
      (set! new-text (list #\-))
      new-text)
  (list->string new-text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "String matching is a big part of RexEx library.") "RES" 0.001)
))

(test-humaneval)
