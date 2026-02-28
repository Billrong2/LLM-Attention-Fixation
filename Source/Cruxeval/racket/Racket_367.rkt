#lang racket

(define (f nums rmvalue)
    (define res (copy-list nums))
    (let loop ((res res))
        (cond
            [(member rmvalue res) (begin
                                    (define popped (list-ref res (index-of res rmvalue)))
                                    (set! res (remove-at res (index-of res rmvalue)))
                                    (when (not (= popped rmvalue))
                                        (set! res (append res (list popped)))
                                        (loop res)))]
            [else res])))

(define (copy-list lst)
    (map values lst))

(define (remove-at lst n)
    (append (take lst n) (drop lst (+ n 1))))

(define (index-of lst val)
    (define n (length lst))
    (let loop ((i 0))
        (cond
            [(>= i n) #f]
            [(equal? (list-ref lst i) val) i]
            [else (loop (+ i 1))])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 6 2 1 1 4 1) 5) (list 6 2 1 1 4 1) 0.001)
))

(test-humaneval)
