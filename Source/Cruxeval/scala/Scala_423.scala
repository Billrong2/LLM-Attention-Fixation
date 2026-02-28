import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(selfie: List[Long]): List[Long] = {
        val selfieBuffer = ListBuffer(selfie: _*)
        val lo = selfieBuffer.length
        for (i <- lo - 1 to 0 by -1) {
            if (selfieBuffer(i) == selfieBuffer(0)) {
                selfieBuffer.remove(lo - 1)
            }
        }
        selfieBuffer.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](4l.toLong, 2l.toLong, 5l.toLong, 1l.toLong, 3l.toLong, 2l.toLong, 6l.toLong))).equals((List[Long](4l.toLong, 2l.toLong, 5l.toLong, 1l.toLong, 3l.toLong, 2l.toLong))));
    }

}
