/// 
func f(c: [String : Int], st: Int, ed: Int) -> (String, String) {
    var d = [Int: String]()
    var a = ""
    var b = ""
    for (x, y) in c {
        d[y] = x
        if y == st {
            a = x
        }
        if y == ed {
            b = x
        }
    }
    let w = d[st] ?? ""
    return a > b ? (w, b) : (b, w)
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
            
assert(f(c: ["TEXT" : 7, "CODE" : 3], st: 7, ed: 3) == ("TEXT", "CODE"))
