import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(array: List[Long], index: Long, value: Long): List[Long] = {
        val mutableArray = ListBuffer(array: _*)
        mutableArray.insert(0, index + 1)
        if (value >= 1) {
            mutableArray.insert(index.toInt, value)
        }
        mutableArray.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](2l.toLong)), (0l), (2l)).equals((List[Long](2l.toLong, 1l.toLong, 2l.toLong))));
    }

}
