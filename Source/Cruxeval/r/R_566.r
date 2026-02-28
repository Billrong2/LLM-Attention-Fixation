f <- function(string, code) {    t <- ''
    tryCatch({
        t <- iconv(string, to = "UTF-8", from = code)
        if (substring(t, nchar(t)) == '\n') {
            t <- substr(t, 1, nchar(t) - 1)
        }
        return(t)
    }, error = function(e) {
        return(t)
    })
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('towaru', 'UTF-8'), 'towaru')))
}
test_humaneval()
