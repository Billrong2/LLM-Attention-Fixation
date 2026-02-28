f <- function(text) {    arr <- unlist(strsplit(text, "\\s+"))
    result <- character(length(arr))
    for (i in 1:length(arr)) {
        if (grepl("day$", arr[i])) {
            arr[i] <- paste0(arr[i], "y")
        } else {
            arr[i] <- paste0(arr[i], "day")
        }
        result[i] <- arr[i]
    }
    return(paste(result, collapse = " "))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('nwv mef ofme bdryl'), 'nwvday mefday ofmeday bdrylday')))
}
test_humaneval()
