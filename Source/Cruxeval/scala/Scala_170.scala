import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], number : Long) : Long = {
        nums.count(_ == number)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](12l.toLong, 0l.toLong, 13l.toLong, 4l.toLong, 12l.toLong)), (12l)) == (2l));
    }

}
