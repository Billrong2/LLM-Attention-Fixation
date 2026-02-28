#lang racket

(define (f code)
  (define lines (regexp-split #rx"]" code))
  (define result '())
  (define level 0)
  (for ([line (in-list lines)])
    (set! result (cons (string-append (string (string-ref line 0)) " " (make-string (* 2 level) #\space) (substring line 1)) result))
    (set! level (+ level (count (lambda (x) (equal? x #\{)) (string->list line)) (- (count (lambda (x) (equal? x #\})) (string->list line))))))
  (string-join (reverse result) "\n"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "if (x) {y = 1;} else {z = 1;}") "i f (x) {y = 1;} else {z = 1;}" 0.001)
))

(test-humaneval)
