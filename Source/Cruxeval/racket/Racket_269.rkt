#lang racket

(define (f array)
  (let* ((zero-len (remainder (- (length array) 1) 3))
         (array-mutable (list->vector array)))
    (for ([i (in-range zero-len)])
      (vector-set! array-mutable i "0"))
    (for ([i (in-range (+ zero-len 1) (vector-length array-mutable) 3)])
      (vector-set! array-mutable (- i 1) "0")
      (vector-set! array-mutable i "0")
      (vector-set! array-mutable (+ i 1) "0"))
    (vector->list array-mutable)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 9 2)) (list "0" 2) 0.001)
))

(test-humaneval)
