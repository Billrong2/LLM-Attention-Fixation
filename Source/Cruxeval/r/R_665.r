f <- function(chars) {    s <- ""
    for (ch in strsplit(chars, "")[[1]]) {
        if (sum(strsplit(chars, "")[[1]] == ch) %% 2 == 0) {
            s <- paste0(s, toupper(ch))
        } else {
            s <- paste0(s, ch)
        }
    }
    return(s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('acbced'), 'aCbCed')))
}
test_humaneval()
