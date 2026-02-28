f <- function(text, value) {    parts <- unlist(strsplit(text, value, fixed=TRUE))
    paste(parts[2], parts[1], sep="")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('difkj rinpx', 'k'), 'j rinpxdif')))
}
test_humaneval()
