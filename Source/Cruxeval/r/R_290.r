f <- function(text, prefix) {    if (startsWith(text, prefix)) {
        substring(text, first = nchar(prefix) + 1)
    } else if (grepl(prefix, text)) {
        gsub(prefix, '', text)
    } else {
        toupper(text)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abixaaaily', 'al'), 'ABIXAAAILY')))
}
test_humaneval()
