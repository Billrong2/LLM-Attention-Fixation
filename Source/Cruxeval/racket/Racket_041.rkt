#lang racket

(define (f array values)
  (let* ((reversed-array (reverse array))
         (updated-array
          (foldl (lambda (value accum)
                   (let ((mid-index (quotient (length accum) 2)))
                     (append (take accum mid-index)
                             (list value)
                             (drop accum mid-index))))
                 reversed-array
                 values)))
    (reverse updated-array)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 58) (list 21 92)) (list 58 92 21) 0.001)
))

(test-humaneval)
