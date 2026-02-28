f <- function(text) {    if (tools::toTitleCase(text) == text) {
        if (nchar(text) > 1 && tolower(text) != text) {
            return(paste(tolower(substr(text, 1, 1)), substr(text, 2, nchar(text)), sep = ''))
        }
    } else if (grepl("^[A-Za-z]*$", text)) {
        return(tools::toTitleCase(text))
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(''), '')))
}
test_humaneval()
