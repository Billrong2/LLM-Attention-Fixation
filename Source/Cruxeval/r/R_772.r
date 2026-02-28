f <- function(phrase) {    result <- ''
    for (i in strsplit(phrase, '')[[1]]) {
        if (!grepl('[a-z]', i)) {
            result <- paste0(result, i)
        }
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('serjgpoDFdbcA.'), 'DFA.')))
}
test_humaneval()
