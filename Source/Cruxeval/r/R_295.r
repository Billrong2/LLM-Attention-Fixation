f <- function(fruits) {    if (fruits[length(fruits)] == fruits[1]) {
        return('no')
    } else {
        fruits <- fruits[-1]
        fruits <- fruits[-length(fruits)]
        fruits <- fruits[-1]
        fruits <- fruits[-length(fruits)]
        return(fruits)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('apple', 'apple', 'pear', 'banana', 'pear', 'orange', 'orange')), c('pear', 'banana', 'pear'))))
}
test_humaneval()
