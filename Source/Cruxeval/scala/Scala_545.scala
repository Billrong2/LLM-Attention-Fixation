import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(array: List[Long]): List[Long] = {
        var result = ListBuffer[Long]()
        var index = 0
        var mutableArray = ListBuffer(array: _*)

        while (index < mutableArray.length) {
            result += mutableArray.remove(mutableArray.length - 1)
            index += 2
        }

        result.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](8l.toLong, 8l.toLong, -4l.toLong, -9l.toLong, 2l.toLong, 8l.toLong, -1l.toLong, 8l.toLong))).equals((List[Long](8l.toLong, -1l.toLong, 8l.toLong))));
    }

}
