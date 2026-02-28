#lang racket

(define (f text)
  (let loop ([index 1])
    (cond
      [(< index (string-length text))
       (if (not (char=? (string-ref text index) (string-ref text (- index 1))))
           (loop (+ index 1))
           (let ([text1 (substring text 0 index)]
                 [text2 (list->string (for/list ([c (in-string (substring text index))])
                                         (if (char-lower-case? c)
                                             (char-upcase c)
                                             (char-downcase c))))])
             (string-append text1 text2)))]
      [else (list->string (for/list ([c (in-string text)])
                            (if (char-lower-case? c)
                                (char-upcase c)
                                (char-downcase c))))])))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "USaR") "usAr" 0.001)
))

(test-humaneval)
