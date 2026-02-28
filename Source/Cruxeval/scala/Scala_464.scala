import scala.math._
import scala.collection.mutable._
object Problem {
    def f(ans : String) : Any = {
        if (ans.forall(_.isDigit)) {
            val total = ans.toLong * 4 - 50
            val subtract = ans.count(c => !"02468".contains(c)) * 100
            total - subtract
        } else {
            "NAN"
        }
    }
    def main(args: Array[String]) = {
    assert(f(("0")).equals(-50l));
    }

}
