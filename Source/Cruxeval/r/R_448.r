f <- function(text, suffix) {    if(suffix == '') {
        suffix <- NULL
    }
    return (substring(text, nchar(text) - nchar(suffix) + 1, nchar(text)) == suffix)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('uMeGndkGh', 'kG'), FALSE)))
}
test_humaneval()
