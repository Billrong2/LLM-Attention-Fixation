f <- function(s, tab) {    gsub("\t", paste(rep(" ", tab), collapse = ""), s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Join us in Hungary', 4), 'Join us in Hungary')))
}
test_humaneval()
