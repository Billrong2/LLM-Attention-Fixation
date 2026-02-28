/// 
func f(list_: [String], num: Int) -> [String] {
    var temp: [String] = []
    for i in list_ {
        let newString = String(repeating: "\(i),", count: num / 2)
        temp.append(newString)
    }
    return temp
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
            
assert(f(list_: ["v"], num: 1) == [""])
