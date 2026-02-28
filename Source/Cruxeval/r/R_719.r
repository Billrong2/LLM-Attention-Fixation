f <- function(code) {
    lines <- unlist(strsplit(code, split="]"))
    result <- c()
    level <- 0
    for (line in lines) {
        if (nchar(line) > 0) {
            result <- c(result, paste0(substr(line, start=1, stop=1), ' ', paste(rep('  ', level), collapse=''), substr(line, start=2, stop=nchar(line))))
        }
        level <- level + (nchar(grep("{", line, fixed=TRUE)) - nchar(grep("}", line, fixed=TRUE)))
    }
    return(paste(result, collapse='\n'))
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('if (x) {y = 1;} else {z = 1;}'), 'i f (x) {y = 1;} else {z = 1;}')))
}
test_humaneval()
