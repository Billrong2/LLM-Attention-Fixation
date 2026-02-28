#lang racket

(define (f text changes)
  (define result "")
  (define count 0)
  (define changes-list (string->list changes))
  (for ([char (in-string text)])
    (set! result (string-append result (if (member char (string->list "e")) (string char) (make-string 1 (list-ref changes-list (remainder count (length changes-list)))))))
    (set! count (+ count (if (member char (string->list "e")) 0 1))))
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "fssnvd" "yes") "yesyes" 0.001)
))

(test-humaneval)
