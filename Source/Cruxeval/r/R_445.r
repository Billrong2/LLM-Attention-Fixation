f <- function(names) {    parts <- strsplit(names, ',')[[1]]
    for (i in 1:length(parts)) {
        parts[i] <- gsub(' and', '+', parts[i])
        parts[i] <- tools::toTitleCase(parts[i])
        parts[i] <- gsub('\\+', ' and', parts[i])
    }
    return(paste(parts, collapse=', '))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('carrot, banana, and strawberry'), 'Carrot,  Banana,  and Strawberry')))
}
test_humaneval()
