f <- function(s, amount) {
    lines <- strsplit(s, '\n')[[1]]
    w <- max(sapply(lines, function(l) unlist(gregexpr('\\s', l))[length(unlist(gregexpr('\\s', l)))]))
    ls <- lapply(lines, function(l) {
        list(l, (w + 1) * amount - unlist(gregexpr('\\s', l))[length(unlist(gregexpr('\\s', l)))])
    })
    ls <- lapply(1:length(ls), function(i) {
        l <- ls[[i]]
        l[[1]] <- paste0(l[[1]], strrep(' ', l[[2]]))
        l
    })
    return(paste0(sapply(ls, `[[`, 1), collapse = '\n'))
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('\n', 2), ' ')))
}
test_humaneval()
