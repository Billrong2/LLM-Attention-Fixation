f <- function(text) {    strings <- unlist(strsplit(text, ","))
    -(nchar(strings[1]) + nchar(strings[2]))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('dog,cat'), -6)))
}
test_humaneval()
