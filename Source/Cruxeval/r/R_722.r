f <- function(text) {    out <- ""
    for (i in seq_len(nchar(text))) {
        if (grepl("[A-Z]", substr(text, i, i))) {
            out <- paste(out, tolower(substr(text, i, i)), sep = "")
        } else {
            out <- paste(out, toupper(substr(text, i, i)), sep = "")
        }
    }
    return(out)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(',wPzPppdl/'), ',WpZpPPDL/')))
}
test_humaneval()
