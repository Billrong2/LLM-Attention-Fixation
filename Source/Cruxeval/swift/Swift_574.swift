func f(simpons: [String]) -> String {
    var simpons = simpons
    while !simpons.isEmpty {
        let pop = simpons.removeLast()
        if pop == pop.prefix(1).uppercased() + pop.dropFirst() {
            return pop
        }
    }
    return simpons.last ?? ""
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
            
assert(f(simpons: ["George", "Michael", "George", "Costanza"]) == "Costanza")
