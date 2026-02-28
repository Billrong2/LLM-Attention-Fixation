f <- function(text) {    result <- character(0)
    for (i in 1:nchar(text)) {
        ch <- substr(text, i, i)
        if (ch == tolower(ch)) {
            next
        }
        if ((nchar(text) - i) < max(gregexpr(tolower(ch), text)[[1]])) {
            result <- c(result, ch)
        }
    }
    paste(result, collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ru'), '')))
}
test_humaneval()
