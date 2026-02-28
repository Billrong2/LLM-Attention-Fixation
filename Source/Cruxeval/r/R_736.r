f <- function(text, insert) {    whitespaces <- c('\t', '\r', '\v', ' ', '\f', '\n')
    clean <- ''
    for (char in strsplit(text, '')[[1]]) {
        if (char %in% whitespaces) {
            clean <- paste0(clean, insert)
        } else {
            clean <- paste0(clean, char)
        }
    }
    return(clean)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('pi wa', 'chi'), 'pichiwa')))
}
test_humaneval()
