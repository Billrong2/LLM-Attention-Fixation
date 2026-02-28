f <- function(text, use) {    return(gsub(use, '', text))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Chris requires a ride to the airport on Friday.', 'a'), 'Chris requires  ride to the irport on Fridy.')))
}
test_humaneval()
