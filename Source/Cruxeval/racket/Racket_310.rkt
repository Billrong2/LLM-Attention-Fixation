#lang racket

(define (f strands)
  (define subs strands)
  (for ([i (in-range (length subs))]
        [j (in-list subs)])
    (define len (quotient (string-length j) 2))
    (for ((_ (in-range len)))
      (set! subs (list-update subs i (lambda (x) (string-append (substring x (- (string-length x) 1)) (substring x 1 (- (string-length x) 1)) (substring x 0 1)))))))
  (apply string-append subs))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "__" "1" "." "0" "r0" "__" "a_j" "6" "__" "6")) "__1.00r__j_a6__6" 0.001)
))

(test-humaneval)
