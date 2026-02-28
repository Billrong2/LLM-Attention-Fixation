#lang racket

(define (f lst)
  (define (vector-sort lst)
    (define (vector-swap v i j)
      (let* ((tmp (vector-ref v i))
             (_ (vector-set! v i (vector-ref v j)))
             (_ (vector-set! v j tmp)))
        v))
    (define (vector-bubble-sort v)
      (for* ((i (in-range (- (vector-length v) 1) 0 -1))
             (j (in-range i)))
        (let ((vi (vector-ref v j))
              (vj (vector-ref v (add1 j))))
          (when (> vi vj)
            (vector-swap v j (add1 j)))))
      v)
    (vector->list (vector-bubble-sort (list->vector lst))))
  (vector-sort lst))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 63 0 1 5 9 87 0 7 25 4)) (list 0 0 1 4 5 7 9 25 63 87) 0.001)
))

(test-humaneval)
