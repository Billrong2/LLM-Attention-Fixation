f <- function(text, char) {    text <- unlist(strsplit(text, ""))
    for (i in 1:length(text)) {
        if (text[i] == char) {
            text <- text[-i]
            return(paste(text, collapse=""))
        }
    }
    paste(text, collapse="")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('pn', 'p'), 'n')))
}
test_humaneval()
