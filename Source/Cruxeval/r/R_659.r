f <- function(bots) {    clean <- vector()
    for (username in bots) {
        if (tolower(username) != username) {
            clean <- c(clean, paste0(substr(username, 1, 2), substr(username, nchar(username) - 2, nchar(username))))
        }
    }
    return(length(clean))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('yR?TAJhIW?n', 'o11BgEFDfoe', 'KnHdn2vdEd', 'wvwruuqfhXbGis')), 4)))
}
test_humaneval()
