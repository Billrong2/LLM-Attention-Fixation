f <- function(s, l) {    sub("=.*", "", substring(paste(s, strrep("=", l), sep = ""), 1, l))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('urecord', 8), 'urecord')))
}
test_humaneval()
