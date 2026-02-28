import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], n : Long) : Long = {
        nums.apply(n.toInt)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](-7l.toLong, 3l.toLong, 1l.toLong, -1l.toLong, -1l.toLong, 0l.toLong, 4l.toLong)), (6l)) == (4l));
    }

}
