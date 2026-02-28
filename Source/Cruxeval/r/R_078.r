f <- function(text) {    if (nchar(text) > 0 && toupper(text) == text) {
        cs <- chartr(paste(LETTERS, collapse = ""), paste(letters, collapse = ""), "")
        return(chartr(cs, text))
    }
    return(tolower(substr(text, 1, 3)))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n'), 'mty')))
}
test_humaneval()
