/// 
func f(tags: [String : String]) -> String {
    var resp = ""
    for key in tags.keys {
        resp += key + " "
    }
    return resp
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
            
assert(f(tags: ["3" : "3", "4" : "5"]) == "3 4 ")
