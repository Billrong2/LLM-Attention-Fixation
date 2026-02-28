#lang racket

(define (f text char)
  (let ((words (string-split text char)))
    (if (empty? words)
        " "
        (apply string-append 
               (map (lambda (word) (string-append word " ")) words)))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "a" "a") " " 0.001)
))

(test-humaneval)
