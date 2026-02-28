import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        var updatedList = nums.filter(_ > 0)
        if (updatedList.length <= 3) {
            return updatedList
        }
        updatedList = updatedList.reverse
        val half = updatedList.length / 2
        updatedList.take(half) ++ List.fill[Long](5)(0) ++ updatedList.drop(half)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](10l.toLong, 3l.toLong, 2l.toLong, 2l.toLong, 6l.toLong, 0l.toLong))).equals((List[Long](6l.toLong, 2l.toLong, 0l.toLong, 0l.toLong, 0l.toLong, 0l.toLong, 0l.toLong, 2l.toLong, 3l.toLong, 10l.toLong))));
    }

}
