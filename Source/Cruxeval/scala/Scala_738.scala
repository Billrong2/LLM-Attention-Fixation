import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, characters : String) : String = {
        var result = text
        for (i <- 0 until characters.length) {
            result = result.reverse.dropWhile(_ == characters(i)).reverse
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("r;r;r;r;r;r;r;r;r"), ("x.r")).equals(("r;r;r;r;r;r;r;r;")));
    }

}
