f <- function(sentence) {
    if (sentence == '') {
        return('')
    }
    sentence <- gsub("\\(|\\)", "", sentence)
    sentence <- gsub(" ", "", tolower(sentence), fixed = TRUE)
    return(gsub("^.", toupper(substr(sentence,1,1)), sentence))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('(A (b B))'), 'Abb')))
}
test_humaneval()
