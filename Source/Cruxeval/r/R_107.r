f <- function(text) {    result <- vector("character", nchar(text))
    for (i in 1:nchar(text)) {
        if (!grepl("[ -~]", substr(text, i, i))) {
            return(FALSE)
        } else if (grepl("[[:alnum:]]", substr(text, i, i))) {
            result[i] <- toupper(substr(text, i, i))
        } else {
            result[i] <- substr(text, i, i)
        }
    }
    paste(result, collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ua6hajq'), 'UA6HAJQ')))
}
test_humaneval()
