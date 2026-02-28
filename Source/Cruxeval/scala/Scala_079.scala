import scala.math._
import scala.collection.mutable._
object Problem {
    def f(arr : List[Long]) : String = {
        val mutableArr = ArrayBuffer.empty[String]
        mutableArr += "1"
        mutableArr += "2"
        mutableArr += "3"
        mutableArr += "4"
        mutableArr.mkString(",")
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](0l.toLong, 1l.toLong, 2l.toLong, 3l.toLong, 4l.toLong))).equals(("1,2,3,4")));
    }

}
