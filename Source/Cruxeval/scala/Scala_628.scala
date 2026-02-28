import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], delete : Long) : List[Long] = {
        nums.filterNot(_ == delete)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](4l.toLong, 5l.toLong, 3l.toLong, 6l.toLong, 1l.toLong)), (5l)).equals((List[Long](4l.toLong, 3l.toLong, 6l.toLong, 1l.toLong))));
    }

}
