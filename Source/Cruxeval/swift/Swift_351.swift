import Foundation

func f(text: String) -> String {
    var mutableText = text
    while mutableText.contains("nnet lloP") {
        mutableText = mutableText.replacingOccurrences(of: "nnet lloP", with: "nnet loLp")
    }
    return mutableText
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
            
assert(f(text: "a_A_b_B3 ") == "a_A_b_B3 ")
