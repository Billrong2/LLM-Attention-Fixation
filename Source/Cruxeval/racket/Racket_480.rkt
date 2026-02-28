#lang racket

(define (f s c1 c2)
  (if (string=? s "")
      s
      (let* ((ls (string-split s c1))
             (new-ls (map (lambda (item) 
                            (if (string-contains? item c1)
                                (regexp-replace #px"^([^\\+]*\\+[^\\+]*)(\\+.*)$" item "\\1")
                                item))
                        ls)))
        (string-join new-ls c2))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "" "mi" "siast") "" 0.001)
))

(test-humaneval)
