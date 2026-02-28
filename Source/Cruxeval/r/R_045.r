f <- function(text, letter) {    counts <- table(strsplit(text, '')[[1]])
    if (letter %in% names(counts)) {
        return(counts[[letter]])
    } else {
        return(0)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('za1fd1as8f7afasdfam97adfa', '7'), 2)))
}
test_humaneval()
