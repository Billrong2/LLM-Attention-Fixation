import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        var l = ListBuffer[Long]()
        for (i <- nums) {
            if (!l.contains(i)) {
                l += i
            }
        }
        l.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](3l.toLong, 1l.toLong, 9l.toLong, 0l.toLong, 2l.toLong, 0l.toLong, 8l.toLong))).equals((List[Long](3l.toLong, 1l.toLong, 9l.toLong, 0l.toLong, 2l.toLong, 8l.toLong))));
    }

}
