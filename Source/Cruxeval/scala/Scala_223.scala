import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long], target : Long) : Long = {
        var count = 0
        var i = 1
        for (j <- 1 until array.length) {
            if (array(j) > array(j-1) && array(j) <= target) {
                count += i
            } else if (array(j) <= array(j-1)) {
                i = 1
            } else {
                i += 1
            }
        }
        count
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, -1l.toLong, 4l.toLong)), (2l)) == (1l));
    }

}
