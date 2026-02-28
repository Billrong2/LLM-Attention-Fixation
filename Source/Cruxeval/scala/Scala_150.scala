import scala.math._
import scala.collection.mutable._
object Problem {
    def f(numbers : List[Long], index : Long) : List[Long] = {
        var mutableNumbers = ListBuffer(numbers: _*)
        var mutableIndex = index.toInt

        for (n <- mutableNumbers.slice(mutableIndex, mutableNumbers.length)) {
            mutableNumbers.insert(mutableIndex, n)
            mutableIndex += 1
        }

        mutableNumbers.slice(0, mutableIndex).toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-2l.toLong, 4l.toLong, -4l.toLong)), (0l)).equals((List[Long](-2l.toLong, 4l.toLong, -4l.toLong))));
    }

}
