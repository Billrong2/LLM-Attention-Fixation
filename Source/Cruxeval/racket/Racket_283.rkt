#lang racket

(define (f dictionary key)
  (cond
    [(not (dict-has-key? dictionary key))
     (error "Key not found")]
    [else
     (dict-remove dictionary (list key))
     (if (equal? (car (sort (dict-keys dictionary) string<?)) key)
         (car (sort (dict-keys dictionary) string<?))
         key)]))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("Iron Man" .  4) ("Captain America" .  3) ("Black Panther" .  0) ("Thor" .  1) ("Ant-Man" .  6)) "Iron Man") "Iron Man" 0.001)
))

(test-humaneval)
