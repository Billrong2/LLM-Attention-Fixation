/// 
func f(a: String) -> String {
    var a = a
    for _ in 0..<10 {
        for j in a.indices {
            if a[j] != "#" {
                a = String(a[j...])
                break
            } else if j == a.index(before: a.endIndex) {
                a = ""
                break
            }
        }
    }
    while a.last == "#" {
        a = String(a.dropLast())
    }
    return a
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
            
assert(f(a: "##fiu##nk#he###wumun##") == "fiu##nk#he###wumun")
