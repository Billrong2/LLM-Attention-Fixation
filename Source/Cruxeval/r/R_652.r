f <- function(string) {    if (nchar(string) == 0 || !grepl('^[0-9]', string)) {
        return('INVALID')
    }
    cur <- 0
    for (i in 1:nchar(string)) {
        cur <- cur * 10 + as.numeric(substr(string, i, i))
    }
    return(as.character(cur))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('3'), '3')))
}
test_humaneval()
