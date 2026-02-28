#lang racket

(define (f text characters)
  (define character-list (append (string->list characters) (list #\space #\_)))
  
  (define (helper i)
    (cond
      [(and (< i (string-length text)) (member (string-ref text i) character-list))
       (helper (+ i 1))]
      [else
       (substring text i)]))
  
  (helper 0))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "2nm_28in" "nm") "2nm_28in" 0.001)
))

(test-humaneval)
