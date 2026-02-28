f <- function(s, separator) {
    for (i in 1:nchar(s)) {
        if (substr(s, i, i) == separator) {
            new_s <- strsplit(s, "")[[1]]
            new_s[i] <- '/'
            return(paste(new_s, collapse = " "))
        }
    }
    return(NULL)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('h grateful k', ' '), 'h / g r a t e f u l   k')))
}
test_humaneval()
