f <- function(text) {    for (i in 1:nchar(text)) {
        if (substr(text, i, i) == toupper(substr(text, i, i)) & grepl("[a-z]", substr(text, i-1, i-1))) {
            return(TRUE)
        }
    }
    return(FALSE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('jh54kkk6'), TRUE)))
}
test_humaneval()
