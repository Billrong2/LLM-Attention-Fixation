#lang racket

(require rackunit)

(define (f items)
  (let loop ([items items] [odd-positioned '()])
    (if (empty? items)
        (reverse odd-positioned)
        (let* ([position (index-of items (apply min items))]
               [items (remove-at items position)]
               [item (list-ref items position)]
               [items (remove-at items position)])
          (loop items (cons item odd-positioned))))))

(define (remove-at lst idx)
  (append (take lst idx) (drop lst (add1 idx))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3 4 5 6 7 8)) (list 2 4 6 8) 0.001)
))

(test-humaneval)
