#lang racket

(define (f replace text hide)
  (define (replace-helper replace)
    (string-append replace "ax"))
  
  (define (f-helper text hide replace)
    (cond
      [(string-contains? text hide)
       (f-helper (string-replace text hide replace) hide (replace-helper replace))]
      [else text]))
  
  (f-helper text hide replace))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "###" "ph>t#A#BiEcDefW#ON#iiNCU" ".") "ph>t#A#BiEcDefW#ON#iiNCU" 0.001)
))

(test-humaneval)
