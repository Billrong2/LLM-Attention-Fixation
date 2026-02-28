f <- function(text) {    result <- ''
    for (char in strsplit(text, '')[[1]]) {
        if (grepl("[[:alnum:]]", char)) {
            result <- paste0(result, toupper(char))
        }
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('с bishop.Swift'), 'СBISHOPSWIFT')))
}
test_humaneval()
