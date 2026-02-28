#lang racket

(define (f text char1 char2)
  (define t1a (string->list char1))
  (define t2a (string->list char2))
  (define t1 (map cons t1a t2a))
  (list->string (map (lambda (c) (let ((x (assoc c t1))) (if x (cdr x) c))) (string->list text))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ewriyat emf rwto segya" "tey" "dgo") "gwrioad gmf rwdo sggoa" 0.001)
))

(test-humaneval)
