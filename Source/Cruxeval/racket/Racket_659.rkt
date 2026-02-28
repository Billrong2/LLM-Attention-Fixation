#lang racket

(define (f bots)
  (define clean '())
  (for ([username (in-list bots)])
    (unless (string->number username)
      (set! clean (cons (string-append (substring username 0 2) (substring username (- (string-length username) 3))) clean))))
  (length clean))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "yR?TAJhIW?n" "o11BgEFDfoe" "KnHdn2vdEd" "wvwruuqfhXbGis")) 4 0.001)
))

(test-humaneval)
