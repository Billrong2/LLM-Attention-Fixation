#lang racket

(define (f playlist liker_name song_index)
  (hash-update playlist liker_name (lambda (likes) 
                                      (if likes 
                                          (append likes (list song_index))
                                          (list song_index)))
              '()))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("aki" .  (list "1" "5"))) "aki" "2") #hash(("aki" .  (list "1" "5" "2"))) 0.001)
))

(test-humaneval)
