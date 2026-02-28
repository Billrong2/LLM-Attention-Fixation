f <- function(s, p) {
    part_one <- nchar(substring(s, 1, regexpr(p, s)[1]-1))
    part_two <- nchar(substring(s, regexpr(p, s)[1], regexpr(p, s)[1]+nchar(p)-1))
    part_three <- nchar(substring(s, regexpr(p, s)[1]+nchar(p), nchar(s)))
    
    if (part_one >= 2 && part_two <= 2 && part_three >= 2) {
        return (paste(rev(strsplit(substring(s, 1, regexpr(p, s)[1]-1), "")[[1]]), substring(s, regexpr(p, s)[1], regexpr(p, s)[1]+nchar(p)-1), paste(rev(strsplit(substring(s, regexpr(p, s)[1]+nchar(p), nchar(s)), "")[[1]]), sep="", collapse=""), "#", sep = ""))
    }
    else {
        return (s)
    }
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('qqqqq', 'qqq'), 'qqqqq')))
}
test_humaneval()
