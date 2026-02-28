import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val words = text.split(" ")
        for (word <- words) {
            if (!word.forall(_.isDigit)) {
                return "no"
            }
        }
        "yes"
    }
    def main(args: Array[String]) = {
    assert(f(("03625163633 d")).equals(("no")));
    }

}
