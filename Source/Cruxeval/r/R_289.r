f <- function(code) {
    paste(code, ": ", paste0("b'", code, "'"), sep="")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('148'), "148: b'148'")))
}
test_humaneval()
