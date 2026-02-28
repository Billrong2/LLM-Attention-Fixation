f <- function(text) {    if(toupper(text) == text) {
        return('ALL UPPERCASE')
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Hello Is It MyClass'), 'Hello Is It MyClass')))
}
test_humaneval()
