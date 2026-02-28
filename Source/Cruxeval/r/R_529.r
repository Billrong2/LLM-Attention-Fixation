f <- function(array) {    prev <- array[1]
    newArray <- array
    for (i in 2:length(array)) {
        if (prev != array[i]) {
            newArray[i] <- array[i]
        } else {
            newArray <- newArray[-i]
        }
        prev <- array[i]
    }
    return(newArray)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3)), c(1, 2, 3))))
}
test_humaneval()
