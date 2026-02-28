#lang racket

(define (f line equalityMap)
  (define rs 
    (filter-map (lambda (pair) 
                  (if (list? pair)
                      (list (string-ref (car pair) 0) (string-ref (cadr pair) 0))
                      #f)) 
                equalityMap))
  (define trans (lambda (c) 
                  (let ((r (assoc c rs)))
                    (if r (cadr r) c))))
  (list->string (map trans (string->list line))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abab" (list (list "a" "b") (list "b" "a"))) "baba" 0.001)
))

(test-humaneval)
