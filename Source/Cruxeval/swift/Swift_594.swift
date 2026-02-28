func f(file: String) -> Int {
    if let index = file.firstIndex(of: "\n") {
        return file.distance(from: file.startIndex, to: index)
    } else {
        return 0
    }
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
            
assert(f(file: "n wez szize lnson tilebi it 504n.\n") == 33)
