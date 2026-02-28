import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        var count = 0
        var temp = ListBuffer(nums: _*)

        for (i <- 0 until nums.length) {
            if (temp.isEmpty) {
                return temp.toList
            }
            if (count % 2 == 0) {
                temp.remove(temp.length - 1)
            } else {
                temp.remove(0)
            }
            count += 1
        }

        temp.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](3l.toLong, 2l.toLong, 0l.toLong, 0l.toLong, 2l.toLong, 3l.toLong))).equals((List[Long]())));
    }

}
