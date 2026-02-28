#lang racket

(define (f text search_chars replace_chars)
  (define trans_table (for/hash ([(c1 c2) (in-parallel (string->list search_chars)
                                                      (string->list replace_chars))])
                               (values c1 c2)))
  (list->string (for/list ([c (in-string text)])
              (hash-ref trans_table c c))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "mmm34mIm" "mm3" ",po") "pppo4pIp" 0.001)
))

(test-humaneval)
