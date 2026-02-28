import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): List[Long] = {
        val buffer = ListBuffer(nums: _*)
        var count = 1
        for (i <- count until nums.length - 1 by 2) {
            buffer(i) = max(buffer(i), buffer(count - 1))
            count += 1
        }
        buffer.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong))).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong))));
    }

}
