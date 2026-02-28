f <- function(text, char) {    length <- nchar(text)
    index <- -1
    for (i in 1:length) {
        if (substr(text, i, i) == char) {
            index <- i
        }
    }
    if (index == -1) {
        index <- length %/% 2
    }
    new_text <- strsplit(text, '')[[1]]
    new_text <- new_text[-index]
    paste(new_text, collapse='')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('o horseto', 'r'), 'o hoseto')))
}
test_humaneval()
