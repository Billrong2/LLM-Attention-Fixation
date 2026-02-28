#lang racket

(define (f original string)
  (define temp (hash-copy original))
  (hash-for-each string (lambda (key value) (hash-set! temp value key)))
  (define sorted-keys (sort (hash-keys temp) <))
  (define sorted-temp (for/hash ([key (in-list sorted-keys)])
                       (values key (hash-ref temp key))))
  sorted-temp)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash((1 .  -9) (0 .  -7)) #hash((1 .  2) (0 .  3))) #hash((1 .  -9) (0 .  -7) (2 .  1) (3 .  0)) 0.001)
))

(test-humaneval)
