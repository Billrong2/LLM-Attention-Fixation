import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        if (text.forall(_.isDigit)) {
            return "yes"
        } else {
            return "no"
        }
    }
    def main(args: Array[String]) = {
    assert(f(("abc")).equals(("no")));
    }

}
