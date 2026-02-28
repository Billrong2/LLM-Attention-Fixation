/// 
func f(ip: String, n: Int) -> String {
    var i = 0
    var out = ""
    for c in ip {
        if i == n {
            out += "\n"
            i = 0
        }
        i += 1
        out += String(c)
    }
    return out
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
            
assert(f(ip: "dskjs hjcdjnxhjicnn", n: 4) == "dskj\ns hj\ncdjn\nxhji\ncnn")
