/// 
func f(n: Int, l: [String]) -> [Int : Int] {
    var archive = [Int: Int]()
    for _ in 0..<n {
        archive.removeAll()
        for x in l {
            archive[x.count + 10] = x.count * 10
        }
    }
    return archive
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
            
assert(f(n: 0, l: ["aaa", "bbb"]) == [:] as [Int : Int])
