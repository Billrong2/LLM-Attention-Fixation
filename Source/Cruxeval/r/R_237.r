f <- function(text, char) {    if (char %in% strsplit(text, '')[[1]]) {
        parts <- unlist(strsplit(text, char, fixed = TRUE))
        pref <- paste0(substring(parts[1], 1, nchar(parts[1]) - nchar(char)),
                       substring(parts[1], nchar(char) + 1),
                       char,
                       parts[2])
        return(paste0(parts[1], char, pref))
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('uzlwaqiaj', 'u'), 'uuzlwaqiaj')))
}
test_humaneval()
