import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        var number = 0
        for (t <- text) {
            if (t.isDigit) {
                number += 1
            }
        }
        number
    }
    def main(args: Array[String]) = {
    assert(f(("Thisisastring")) == (0l));
    }

}
