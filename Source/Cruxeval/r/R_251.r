f <- function(messages) {
    phone_code <- c("+", "3", "5", "3")
    result <- c()
    for (message in messages) {
        message <- c(message, phone_code)
        result <- c(result, paste(message, collapse=";"))
    }
    paste(result, collapse=". ")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(c('Marie', 'Nelson', 'Oscar'))), 'Marie;Nelson;Oscar;+;3;5;3')))
}
test_humaneval()
