f <- function(text, ch) {    result <- character()
    for (line in strsplit(text, "\n")[[1]]) {
        if (nchar(line) > 0 && substr(line, 1, 1) == ch) {
            result <- c(result, tolower(line))
        } else {
            result <- c(result, toupper(line))
        }
    }
    paste(result, collapse = "\n")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('t\nza\na', 't'), 't\nZA\nA')))
}
test_humaneval()
