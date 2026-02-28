import scala.math._
import scala.collection.mutable._
object Problem {
    def f(sentence : String) : Boolean = {
        for (c <- sentence) {
            if (!c.isLetterOrDigit) {
                return false
            }
        }
        true
    }
    def main(args: Array[String]) = {
    assert(f(("1z1z1")) == (true));
    }

}
