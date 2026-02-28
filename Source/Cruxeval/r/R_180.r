f <- function(nums) {    a <- -1
    b <- nums[-1]
    while (a <= b[1]){
        nums <- nums[-match(b[1], nums)]
        a <- 0
        b <- b[-1]
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-1, 5, 3, -2, -6, 8, 8)), c(-1, -2, -6, 8, 8))))
}
test_humaneval()
