import scala.math._
import scala.collection.mutable._
object Problem {
    def f(num1 : Long, num2 : Long, num3 : Long) : String = {
        val nums = List(num1, num2, num3).sorted
        s"${nums(0)},${nums(1)},${nums(2)}"
    }
    def main(args: Array[String]) = {
    assert(f((6l), (8l), (8l)).equals(("6,8,8")));
    }

}
