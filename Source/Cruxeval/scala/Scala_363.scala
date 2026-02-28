import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        val sortedNums = nums.sorted
        val n = sortedNums.length
        var newNums = List(sortedNums(n/2))

        if (n % 2 == 0) {
            newNums = List(sortedNums(n/2 - 1), sortedNums(n/2))
        }

        for (i <- 0 until n/2) {
            newNums = sortedNums(n-i-1) +: newNums
            newNums = newNums :+ sortedNums(i)
        }
        newNums
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong))).equals((List[Long](1l.toLong))));
    }

}
