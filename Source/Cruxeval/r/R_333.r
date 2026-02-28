f <- function(places, lazy) {
    places <- sort(places)
    places <- places[!places %in% lazy]
    if(length(places) == 1){
        return(1)
    }
    for(i in 1:length(places)){
        if(length(which(places == places[i] + 1)) == 0){
            return(i)
        }
    }
    return(i)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(375, 564, 857, 90, 728, 92), c(728)), 1)))
}
test_humaneval()
