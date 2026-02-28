#lang racket

(define (f array)
  (let* ((prev (first array))
         (newArray (rest array)))
    (let loop ((restArray newArray)
               (result (list (first array)))
               (prev-val (first array)))
      (cond ((empty? restArray)
             (reverse result))
            ((equal? prev-val (first restArray))
             (loop (rest restArray) result prev-val))
            (else
             (loop (rest restArray)
                   (cons (first restArray) result)
                   (first restArray)))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3)) (list 1 2 3) 0.001)
))

(test-humaneval)
