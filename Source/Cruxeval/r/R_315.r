f <- function(challenge) {    tolower(gsub("l", ",", challenge, fixed = TRUE))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('czywZ'), 'czywz')))
}
test_humaneval()
