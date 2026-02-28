/// 
func f(name: String) -> String {
    var result = name
    if name == name.lowercased() {
        result = name.uppercased()
    } else {
        result = name.lowercased()
    }
    return result
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
            
assert(f(name: "Pinneaple") == "pinneaple")
