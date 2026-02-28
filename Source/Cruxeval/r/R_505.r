f <- function(string) {    while (nchar(string) > 0) {
        if (grepl("[a-zA-Z]", substr(string, nchar(string), nchar(string)))) {
            return(string)
        }
        string <- substr(string, 1, nchar(string)-1)
    }
    return(string)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('--4/0-209'), '')))
}
test_humaneval()
