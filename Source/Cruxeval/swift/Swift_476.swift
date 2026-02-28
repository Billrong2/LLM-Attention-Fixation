/// 
func f(a: String, split_on: String) -> Bool {
    let t = a.split(separator: " ")
    var a = [String]()
    
    for i in t {
        for j in i {
            a.append(String(j))
        }
    }
    
    if a.contains(split_on) {
        return true
    } else {
        return false
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
            
assert(f(a: "booty boot-boot bootclass", split_on: "k") == false)
