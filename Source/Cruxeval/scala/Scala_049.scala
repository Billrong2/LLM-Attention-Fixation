import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        if (text.matches("[a-zA-Z_][a-zA-Z0-9_]*")) {
            return text.filter(_.isDigit)
        } else {
            return text
        }
    }
    def main(args: Array[String]) = {
    assert(f(("816")).equals(("816")));
    }

}
