f <- function(string) {    tmp <- tolower(string)
    for (char in tolower(string)) {
        if (char %in% tmp) {
            tmp <- gsub(char, '', tmp, fixed = TRUE)
        }
    }
    return(tmp)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('[ Hello ]+ Hello, World!!_ Hi'), '')))
}
test_humaneval()
