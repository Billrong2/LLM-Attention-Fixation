import scala.math._
import scala.collection.mutable._
object Problem {
    def f(cat : String) : Long = {
        var digits = 0
        for (char <- cat) {
            if (char.isDigit) {
                digits += 1
            }
        }
        digits
    }
    def main(args: Array[String]) = {
    assert(f(("C24Bxxx982ab")) == (5l));
    }

}
