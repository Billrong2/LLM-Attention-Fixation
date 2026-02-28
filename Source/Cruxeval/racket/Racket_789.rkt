#lang racket

(define (f text n)
  (if (or (< n 0) (>= (string-length text) n))
      text
      (let* ((result (substring text 0 n))
             (i (- (string-length result) 1)))
        (let loop ((i i))
          (if (>= i 0)
              (if (not (char=? (string-ref result i) (string-ref text i)))
                  (substring text 0 (+ i 1))
                  (loop (- i 1)))
              (substring text 0 (+ i 1)))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "bR" -1) "bR" 0.001)
))

(test-humaneval)
