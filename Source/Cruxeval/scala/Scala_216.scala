import scala.math._
import scala.collection.mutable._
object Problem {
    def f(letters : String) : Long = {
        var count = 0
        for (l <- letters) {
            if (l.isDigit) {
                count += 1
            }
        }
        count
    }
    def main(args: Array[String]) = {
    assert(f(("dp ef1 gh2")) == (2l));
    }

}
