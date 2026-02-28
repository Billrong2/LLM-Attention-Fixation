f <- function(text) {    sum(nchar(gsub("[^[:digit:]]", "", text)))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('so456'), 3)))
}
test_humaneval()
