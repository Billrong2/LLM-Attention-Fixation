f <- function(text, char) {    nchar(text, type = "char") %% 2 != 0
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abababac', 'a'), FALSE)))
}
test_humaneval()
