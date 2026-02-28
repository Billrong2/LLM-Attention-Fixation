f <- function(text) {    if (text == '42.42') {
        return(TRUE)
    }
    for (i in 4:(nchar(text) - 2)) {
        if (substr(text, i, i) == '.' && is.numeric(substr(text, i - 3, nchar(text))) && is.numeric(substr(text, 1, i - 1))) {
            return(TRUE)
        }
    }
    return(FALSE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('123E-10'), FALSE)))
}
test_humaneval()
