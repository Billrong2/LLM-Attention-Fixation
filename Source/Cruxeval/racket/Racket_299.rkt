#lang racket

(define (f text char)
  (if (not (string=? char (substring text (- (string-length text) (string-length char)))))
      (f (string-append char text) char)
      text))
      
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "staovk" "k") "staovk" 0.001)
))

(test-humaneval)
