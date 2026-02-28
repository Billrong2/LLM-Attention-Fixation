import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long], values : List[Long]) : List[Long] = {
        var mutableArray = ListBuffer(array: _*)
        mutableArray = mutableArray.reverse
        for (value <- values) {
            mutableArray.insert(mutableArray.length / 2, value)
        }
        mutableArray = mutableArray.reverse
        mutableArray.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](58l.toLong)), (List[Long](21l.toLong, 92l.toLong))).equals((List[Long](58l.toLong, 92l.toLong, 21l.toLong))));
    }

}
