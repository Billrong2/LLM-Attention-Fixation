/// 
func f(years: [Int]) -> Int {
    let a10 = years.filter { $0 <= 1900 }.count
    let a90 = years.filter { $0 > 1910 }.count
    
    if a10 > 3 {
        return 3
    } else if a90 > 3 {
        return 1
    } else {
        return 2
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
            
assert(f(years: [1872, 1995, 1945]) == 2)
