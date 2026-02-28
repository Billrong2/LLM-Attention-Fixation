import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        val nums = s.filter(_.isDigit)
        if (nums.isEmpty) {
            return "none"
        }
        val m = nums.split(',').map(_.toInt).max
        m.toString
    }
    def main(args: Array[String]) = {
    assert(f(("01,001")).equals(("1001")));
    }

}
