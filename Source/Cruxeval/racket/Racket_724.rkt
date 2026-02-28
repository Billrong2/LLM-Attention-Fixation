#lang racket

(define (f text function)
  (define cites (list (string-length (substring text (string-length function)))))
  (define found #f)
  (for ([char (in-string text)])
    (when (and (char=? char (string-ref function 0)) (not found))
      (set! cites (list (string-length (substring text (string-length function)))))
      (set! found #t)))
  cites)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "010100" "010") (list 3) 0.001)
))

(test-humaneval)
