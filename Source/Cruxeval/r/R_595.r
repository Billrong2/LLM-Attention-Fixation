f <- function(text, prefix) {
    if (startsWith(text, prefix)) {
        text <- sub(prefix, "", text)
    }
    text <- paste(toupper(substring(text, 1, 1)), tolower(substring(text, 2)), sep="")
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('qdhstudentamxupuihbuztn', 'jdm'), 'Qdhstudentamxupuihbuztn')))
}
test_humaneval()
