f <- function(text, width) {
    lines <- strsplit(text, '\n')[[1]]
    lines <- sapply(lines, function(line) {
        padding <- max(0, width - nchar(line))
        before <- ceiling(padding / 2)
        after <- floor(padding / 2)
        paste0(strrep(' ', before), line, strrep(' ', after))
    })
    return(paste(lines, collapse = '\n'))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('a\nbc\n\nd\nef', 5), '  a  \n  bc \n     \n  d  \n  ef ')))
}
test_humaneval()
