/// 
func f(bots: [String]) -> Int {
    var clean: [String] = []
    for username in bots {
        if username != username.uppercased() {
            clean.append(String(username.prefix(2) + username.suffix(3)))
        }
    }
    return clean.count
}


func ==(left: [(Int, Int)], right: [(Int, Int)]) -> Bool {
    if left.count != right.count {
        return false
    }
    for (l, r) in zip(left, right) {
        if l != r {
            return false
        }
    }
    return true
}
            
assert(f(bots: ["yR?TAJhIW?n", "o11BgEFDfoe", "KnHdn2vdEd", "wvwruuqfhXbGis"]) == 4)
