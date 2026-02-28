#lang racket

(define (f items item)
  (let loop ()
    (when (and (not (empty? items))
               (equal? item (last items)))
      (set! items (remove item items))
      (loop)))
  (set! items (append items (list item)))
  (length items))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "bfreratrrbdbzagbretaredtroefcoiqrrneaosf") "n") 2 0.001)
))

(test-humaneval)
