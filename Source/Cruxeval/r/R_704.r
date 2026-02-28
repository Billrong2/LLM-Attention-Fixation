f <- function(s, n, c) {    width <- nchar(c) * n
    while (nchar(s) < width) {
        s <- paste0(c, s)
    }
    s
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('.', 0, '99'), '.')))
}
test_humaneval()
