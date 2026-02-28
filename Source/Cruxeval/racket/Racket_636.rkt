#lang racket

(define (dict-set dict key value)
  (hash-set dict key value))

(define (dict-remove dict key)
  (hash-remove dict key))

(define (dict-count dict)
  (hash-count dict))

(define (dict-keys dict)
  (hash-keys dict))

(define (dict-ref dict key)
  (hash-ref dict key))

(define (f d)
  (define r (hash))
  (let loop ()
    (when (> (dict-count d) 0)
      (set! r (dict-set r (apply max (dict-keys d)) (dict-ref d (apply max (dict-keys d)))))
      (set! d (dict-remove d (apply max (dict-keys d))))
      (loop)))
  r)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash((3 .  "A3") (1 .  "A1") (2 .  "A2"))) #hash((3 .  "A3") (1 .  "A1") (2 .  "A2")) 0.001)
))

(test-humaneval)
