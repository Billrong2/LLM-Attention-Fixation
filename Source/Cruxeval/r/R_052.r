f <- function(text) {    a <- character(0)
    for (i in 1:nchar(text)) {
        if (!grepl("\\d", substr(text, i, i))) {
            a <- c(a, substr(text, i, i))
        }
    }
    paste(a, collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('seiq7229 d27'), 'seiq d')))
}
test_humaneval()
