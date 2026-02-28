f <- function(text) {    
    result = ""
    for (i in 1:nchar(text)) {
        if (i %% 2 == 0) {
            result <- paste0(result, tolower(substr(text, i, i)))
        } else {
            result <- paste0(result, toupper(substr(text, i, i)))
        }
    }
    return(result)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('vsnlygltaw'), 'VsNlYgLtAw')))
}
test_humaneval()
