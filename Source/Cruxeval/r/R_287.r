f <- function(name) {    if (tolower(name) == name) {
        toupper(name)
    } else {
        tolower(name)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Pinneaple'), 'pinneaple')))
}
test_humaneval()
