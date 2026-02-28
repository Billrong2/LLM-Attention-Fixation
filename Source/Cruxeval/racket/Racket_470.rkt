#lang racket

(define (f number)
  (define transl '(("A" . 1) ("B" . 2) ("C" . 3) ("D" . 4) ("E" . 5)))
  (define result '())
  (for/list ((pair transl))
    (let ((key (car pair))
          (value (cdr pair)))
      (when (zero? (remainder value number))
        (set! result (cons key result)))))
  (reverse result))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 2) (list "B" "D") 0.001)
))

(test-humaneval)
