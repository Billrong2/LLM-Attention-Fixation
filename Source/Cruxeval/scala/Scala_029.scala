import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val nums = text.filter(_.isDigit)
        assert(nums.length > 0)
        nums.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("-123   	+314")).equals(("123314")));
    }

}
