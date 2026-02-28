f <- function(text) {    ws <- 0
    for (s in strsplit(text, '')[[1]]) {
        if (s %in% c(' ', '\t', '\n')) {
            ws <- ws + 1
        }
    }
    return(c(ws, nchar(text)))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('jcle oq wsnibktxpiozyxmopqkfnrfjds'), c(2, 34))))
}
test_humaneval()
