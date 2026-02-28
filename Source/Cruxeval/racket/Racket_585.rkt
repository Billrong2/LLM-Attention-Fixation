#lang racket

(define (count-char str char)
  (for/fold ([count 0]) ([c (in-string str)])
    (if (char=? c char)
        (+ count 1)
        count)))

(define (f text)
  (define count (count-char text (string-ref text 0)))
  (define ls (string->list text))
  (for ([_ (in-range count)])
    (set! ls (remove (string-ref text 0) ls)))
  (list->string ls))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate ";,,,?") ",,,?" 0.001)
))

(test-humaneval)
