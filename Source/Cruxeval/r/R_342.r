f <- function(text) {    sum(unlist(strsplit(text, "")) == "-") == nchar(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('---123-4'), FALSE)))
}
test_humaneval()
