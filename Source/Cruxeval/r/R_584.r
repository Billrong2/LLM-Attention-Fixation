f <- function(txt) {    return(txt) }
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('5123807309875480094949830'), '5123807309875480094949830')))
}
test_humaneval()
