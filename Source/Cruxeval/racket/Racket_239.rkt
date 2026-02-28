#lang racket

(define (f text froms)
  (define froms-list (string->list froms))
  (define text-list (string->list text))
  
  (let loop ((l text-list))
    (if (and (not (null? l)) (member (first l) froms-list))
        (loop (rest l))
        (set! text-list l)))
  
  (set! text-list (reverse text-list))
  
  (let loop ((l text-list))
    (if (and (not (null? l)) (member (first l) froms-list))
        (loop (rest l))
        (set! text-list l)))
  
  (list->string (reverse text-list)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "0 t 1cos " "st 0	
  ") "1co" 0.001)
))

(test-humaneval)
