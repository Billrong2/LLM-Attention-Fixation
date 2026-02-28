/// 
func f(array: [Int]) -> [String] {
    let just_ns = array.map({String(repeating: "n", count: $0)})
    var final_output: [String] = []
    for wipe in just_ns {
        final_output.append(wipe)
    }
    return final_output
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
            
assert(f(array: [] as [Int]) == [] as [String])
