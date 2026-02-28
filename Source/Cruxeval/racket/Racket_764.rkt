#lang racket

(define (f text old new)
  (let* ((text2 (regexp-replace* (regexp old) text new))
         (old2 (list->string (reverse (string->list old)))))
    (let loop ((text3 text2))
      (if (string-contains? text3 old2)
          (loop (regexp-replace* (regexp old2) text3 new))
          text3))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "some test string" "some" "any") "any test string" 0.001)
))

(test-humaneval)
