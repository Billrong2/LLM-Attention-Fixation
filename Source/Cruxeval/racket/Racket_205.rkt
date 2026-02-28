#lang racket

(define (f a)
    (define (helper a)
        (cond
            [(= (string-length a) 0) ""]
            [(string=? (substring a 0 1) "#") (helper (substring a 1))]
            [else a]))
    
    (define (remove-trailing-sharps str)
        (cond
            [(string=? (substring str (- (string-length str) 1)) "#") (remove-trailing-sharps (substring str 0 (- (string-length str) 1)))]
            [else str]))
    
    (define result (remove-trailing-sharps (helper a)))
    result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "##fiu##nk#he###wumun##") "fiu##nk#he###wumun" 0.001)
))

(test-humaneval)
