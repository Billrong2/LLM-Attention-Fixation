f <- function(length, text) {    if(nchar(text) == length) {
        return (substr(text, nchar(text):1, 1))
    } else {
        return(FALSE)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(-5, 'G5ogb6f,c7e.EMm'), FALSE)))
}
test_humaneval()
