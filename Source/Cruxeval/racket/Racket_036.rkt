#lang racket

(define (f text chars)
  (if (string=? text "")
      text
      (let* ((chars-list (string->list chars))
             (text-list (string->list text))
             (rev-text-list (reverse text-list))
             (rev-stripped-text-list (remove* chars-list rev-text-list))
             (stripped-text-list (reverse rev-stripped-text-list)))
        (list->string stripped-text-list))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ha" "") "ha" 0.001)
))

(test-humaneval)
