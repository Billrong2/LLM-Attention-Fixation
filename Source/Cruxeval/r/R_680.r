f <- function(text) {    letters <- ''
    for (i in 1:nchar(text)) {
        if (grepl("[[:alnum:]]", substr(text, i, i), perl = TRUE)) {
            letters <- paste0(letters, substr(text, i, i))
        }
    }
    return(letters)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('we@32r71g72ug94=(823658*!@324'), 'we32r71g72ug94823658324')))
}
test_humaneval()
