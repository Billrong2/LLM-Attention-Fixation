/// 
func f(text: String) -> Int {
    var m = 0
    var cnt = 0
    for i in text.split(separator: " ") {
        if i.count > m {
            cnt += 1
            m = i.count
        }
    }
    return cnt
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
            
assert(f(text: "wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl") == 2)
