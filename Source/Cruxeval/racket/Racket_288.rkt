#lang racket

(define (f d)
  (define sorted-pairs
    (sort (hash->list d)
          (lambda (x y)
            (< (string-length (string-append (number->string (car x)) (number->string (cdr x))))
               (string-length (string-append (number->string (car y)) (number->string (cdr y))))))))
  (map (lambda (pair) (list (car pair) (cdr pair)))
       (filter (lambda (pair) (< (car pair) (cdr pair))) sorted-pairs)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash((55 .  4) (4 .  555) (1 .  3) (99 .  21) (499 .  4) (71 .  7) (12 .  6))) (list (list 1 3) (list 4 555)) 0.001)
))

(test-humaneval)
