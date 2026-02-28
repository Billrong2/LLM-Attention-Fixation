f <- function(xs) {    new_x <- xs[1] - 1
    xs <- xs[-1]
    while (new_x <= xs[1]) {
        xs <- xs[-1]
        new_x <- new_x - 1
    }
    xs <- c(new_x, xs)
    xs
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(6, 3, 4, 1, 2, 3, 5)), c(5, 3, 4, 1, 2, 3, 5))))
}
test_humaneval()
