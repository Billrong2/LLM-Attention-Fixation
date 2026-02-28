#lang racket

(define (f text space_symbol size)
  (define spaces (apply string-append (build-list (- size (string-length text)) 
                                                 (λ (_) space_symbol))))
  (string-append text spaces))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "w" "))" 7) "w))))))))))))" 0.001)
))

(test-humaneval)
