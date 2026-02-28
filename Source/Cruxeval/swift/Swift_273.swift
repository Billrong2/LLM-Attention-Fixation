/// 
func f(name: String) -> String {
    var new_name = ""
    var reversedName = String(name.reversed())
    
    for n in reversedName {
        if n != "." && new_name.filter({ $0 == "." }).count < 2 {
            new_name = String(n) + new_name
        } else {
            break
        }
    }
    
    return new_name
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
            
assert(f(name: ".NET") == "NET")
