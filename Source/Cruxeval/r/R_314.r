f <- function(text) {
    if (grepl(',', text)) {
        parts <- strsplit(text, ',')[[1]]
        before <- parts[1]
        after <- paste(parts[-1], collapse = ',')
        return(paste(after, before))
    }
    parts <- strsplit(text, ' ')[[1]]
    return(paste0(',', parts[length(parts)], ' 0'))
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('244, 105, -90'), ' 105, -90 244')))
}
test_humaneval()
