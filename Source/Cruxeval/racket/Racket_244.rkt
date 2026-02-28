#lang racket

(define (f text symbols)
  (define count 0)
  (if (not (equal? symbols ""))
      (for ([i (in-string symbols)])
        (set! count (+ count 1)))
      (set! count 0))
  (if (not (equal? symbols ""))
      (set! text (string-append (string-append (make-string count #\space) text)
                                (make-string count #\space)))
      "")
  (substring text 0 (- (string-length text) 2)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "" "BC1ty") "        " 0.001)
))

(test-humaneval)
