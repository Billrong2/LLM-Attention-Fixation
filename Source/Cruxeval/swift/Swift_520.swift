/// 
func f(album_sales: [Int]) -> Int {
    var sales = album_sales
    while sales.count != 1 {
        sales.append(sales.removeFirst())
    }
    return sales[0]
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
            
assert(f(album_sales: [6]) == 6)
