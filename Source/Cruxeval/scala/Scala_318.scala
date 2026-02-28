import scala.math._
import scala.collection.mutable._
object Problem {
    def f(value : String, char : String) : Long = {
        var total = 0
        for (c <- value) {
            if (c.toString == char || c.toString == char.toLowerCase) {
                total += 1
            }
        }
        total
    }
    def main(args: Array[String]) = {
    assert(f(("234rtccde"), ("e")) == (1l));
    }

}
