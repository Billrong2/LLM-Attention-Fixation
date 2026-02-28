#lang racket

(define (f array)
  (define just_ns (map (lambda (num) (make-string num #\n)) array))
  (define final_output '())
  (for-each (lambda (wipe) (set! final_output (append final_output (list wipe)))) just_ns)
  final_output)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list )) (list ) 0.001)
))

(test-humaneval)
