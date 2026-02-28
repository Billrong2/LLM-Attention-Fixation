f <- function(text) {    for (i in 1:nchar(text)) {
        c <- substring(text, i, i)
        if (grepl("[0-9]", c)) {
            if (c == '0') {
                c <- '.'
            } else {
                c <- ifelse(c != '1', '0', '.')
            }
        }
    }
    return(gsub("\\.", "0", text))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('697 this is the ultimate 7 address to attack'), '697 this is the ultimate 7 address to attack')))
}
test_humaneval()
