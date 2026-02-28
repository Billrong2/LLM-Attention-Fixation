f <- function(strs) {    words <- strsplit(strs, " ")[[1]]
    for (i in seq(2, length(words), by = 2)) {
        words[i] <- paste0(rev(strsplit(words[i], "")[[1]]), collapse = "")
    }
    return(paste(words, collapse = " "))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('K zBK'), 'K KBz')))
}
test_humaneval()
