f <- function(text) {    valid_chars <- c('-', '_', '+', '.', '/', ' ')
    text <- toupper(text)
    for (char in strsplit(text, '')[[1]]) {
        if (!grepl(char, pattern = '[A-Za-z0-9]') && !(char %in% valid_chars)) {
            return(FALSE)
        }
    }
    return(TRUE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW'), FALSE)))
}
test_humaneval()
