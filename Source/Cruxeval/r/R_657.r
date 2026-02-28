f <- function(text) {
    for (punct in c('!', '.', '?', ',', ':', ';')) {
        if (sum(strsplit(text, '')[[1]] == punct) > 1) {
            return('no')
        }
        if (endsWith(text, punct)) {
            return('no')
        }
    }
    return(gsub("(\\w)(\\w*)", "\\U\\1\\L\\2", text, perl = TRUE))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('djhasghasgdha'), 'Djhasghasgdha')))
}
test_humaneval()
