f <- function(phrase) {    ans <- 0
    words <- strsplit(phrase, "\\s")[[1]]
    for (word in words) {
        for (i in 1:nchar(word)) {
            if (substr(word, i, i) == "0") {
                ans <- ans + 1
            }
        }
    }
    return(ans)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('aboba 212 has 0 digits'), 1)))
}
test_humaneval()
