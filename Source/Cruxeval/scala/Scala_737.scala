import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : Long = {
        var counts = 0
        for (i <- nums) {
            if (i.toString.forall(_.isDigit)) {
                if (counts == 0) {
                    counts += 1
                }
            }
        }
        counts
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](0l.toLong, 6l.toLong, 2l.toLong, -1l.toLong, -2l.toLong))) == (1l));
    }

}
