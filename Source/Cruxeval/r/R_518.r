f <- function(text) {    !grepl("^\\d+$", text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('the speed is -36 miles per hour'), TRUE)))
}
test_humaneval()
