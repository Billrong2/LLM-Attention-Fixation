#lang racket

(define (f x y)
  (define tmp (list->string (for/list ([c (in-string y)])
                             (if (char=? c #\9)
                                 #\0
                                 #\9))))
  (if (string->number x)
      (if (string->number tmp)
          (string-append x tmp)
          x)
      x))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "" "sdasdnakjsda80") "" 0.001)
))

(test-humaneval)
