f <- function(text) {    for(i in 1:(nchar(text) - 1)) {
        if (grepl("^[a-z]+$", substr(text, i, nchar(text)))) {
            return(substr(text, i + 1, nchar(text)))
        }
    }
    return('')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('wrazugizoernmgzu'), 'razugizoernmgzu')))
}
test_humaneval()
