f <- function(text) {    n <- as.numeric(gregexpr("8", text)[[1]][1]) - 1
    paste(rep("x0", n), collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('sa832d83r xd 8g 26a81xdf'), 'x0x0')))
}
test_humaneval()
