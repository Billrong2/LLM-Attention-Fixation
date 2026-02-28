f <- function(perc, full) {    reply <- ""
    i <- 1
    while (i <= nchar(perc) && i <= nchar(full) && substr(perc, i, i) == substr(full, i, i)) {
        if (substr(perc, i, i) == substr(full, i, i)) {
            reply <- paste0(reply, "yes ")
        } else {
            reply <- paste0(reply, "no ")
        }
        i <- i + 1
    }
    return(reply)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('xabxfiwoexahxaxbxs', 'xbabcabccb'), 'yes ')))
}
test_humaneval()
