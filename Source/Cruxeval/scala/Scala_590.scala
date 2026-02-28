import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var result = text
        for (i <- 10 to 1 by -1) {
            result = result.stripPrefix(i.toString)
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("25000   $")).equals(("5000   $")));
    }

}
