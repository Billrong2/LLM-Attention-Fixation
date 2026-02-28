import scala.math._
import scala.collection.mutable._
object Problem {
    def f(lst : List[Long], start : Long, end : Long) : Long = {
        var count = 0l
        for (i <- start until end) {
            for (j <- i until end) {
                if (lst(i.toInt) != lst(j.toInt)) {
                    count += 1
                }
            }
        }
        count
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 4l.toLong, 3l.toLong, 2l.toLong, 1l.toLong)), (0l), (3l)) == (3l));
    }

}
