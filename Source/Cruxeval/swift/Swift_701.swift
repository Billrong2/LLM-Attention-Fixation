/// 
func f(stg: String, tabs: [String]) -> String {
    var newStg = stg
    for tab in tabs {
        while newStg.hasSuffix(tab) {
            newStg.removeLast()
        }
    }
    return newStg
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
            
assert(f(stg: "31849 let it!31849 pass!", tabs: ["3", "1", "8", " ", "1", "9", "2", "d"]) == "31849 let it!31849 pass!")
