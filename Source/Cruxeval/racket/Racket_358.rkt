#lang racket

(define (f text value)
  (define indexes (for/list ([i (in-range (string-length text))]
                            #:when (and (char=? (string-ref text i) (string-ref value 0))
                                        (or (= i 0)
                                            (not (char=? (string-ref text (- i 1)) (string-ref value 0))))))
                   i))
  (if (odd? (length indexes))
      text
      (substring text (+ (car indexes) 1) (car (reverse indexes)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "btrburger" "b") "tr" 0.001)
))

(test-humaneval)
