f <- function(s) {    if (grepl("^[[:alnum:]]+$", s)) {
        return("True")
    } else {
        return("False")
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('777'), 'True')))
}
test_humaneval()
