f <- function(text, lower, upper) {    substring(text, lower, upper) %in% iconv(substring(text, lower, upper), to = "ASCII", sub = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('=xtanp|sugv?z', 3, 6), TRUE)))
}
test_humaneval()
