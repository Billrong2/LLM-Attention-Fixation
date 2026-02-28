f <- function(xs) {    for (idx in seq_along(xs)) {
        insert_pos <- length(xs) - idx + 1
        xs <- c(xs[1:insert_pos], xs[-c(1:insert_pos)])
    }
    xs
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3)), c(1, 2, 3))))
}
test_humaneval()
