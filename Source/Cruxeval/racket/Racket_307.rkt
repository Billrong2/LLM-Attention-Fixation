#lang racket

(define (f text)
  (define rtext (string->list text))
  (for ([i (in-range 1 (- (length rtext) 1))])
    (set! rtext (append (take rtext (+ i 1)) (list #\|) (drop rtext (+ i 1)))))
  (list->string rtext))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "pxcznyf") "px|||||cznyf" 0.001)
))

(test-humaneval)
