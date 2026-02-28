f <- function(s) {    gsub("\\(", "[", gsub("\\)", "]", s))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('(ac)'), '[ac]')))
}
test_humaneval()
