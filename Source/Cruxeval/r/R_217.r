f <- function(string) {    if (grepl("^[A-Za-z0-9]+$", string)) {
        return("ascii encoded is allowed for this language")
    } else {
        return("more than ASCII")
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Str zahrnuje anglo-ameriæske vasi piscina and kuca!'), 'more than ASCII')))
}
test_humaneval()
