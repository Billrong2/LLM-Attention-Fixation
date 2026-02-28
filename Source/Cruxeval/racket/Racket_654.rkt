#lang racket

(define (f s from_c to_c)
  (define table (map cons (string->list from_c) (string->list to_c)))
  (list->string (map (lambda (c) 
                       (let ((t (assoc c table))) 
                         (if t (cdr t) c))) 
                     (string->list s))))

(require rackunit)

(define (test-check)
  (check-equal? (f "example" "example" "example") "example"))

(test-check)
```
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "aphid" "i" "?") "aph?d" 0.001)
))

(test-humaneval)
