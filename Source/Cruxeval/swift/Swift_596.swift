/// 
func f(txt: [String], alpha: String) -> [String] {
    var txt = txt.sorted()
    if let index = txt.firstIndex(of: alpha), index % 2 == 0 {
        return txt.reversed()
    }
    return txt
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
            
assert(f(txt: ["8", "9", "7", "4", "3", "2"], alpha: "9") == ["2", "3", "4", "7", "8", "9"])
