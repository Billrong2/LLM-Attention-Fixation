import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        var counter = 0
        for (char <- text) {
            if (char.isLetter) {
                counter += 1
            }
        }
        counter
    }
    def main(args: Array[String]) = {
    assert(f(("l000*")) == (1l));
    }

}
