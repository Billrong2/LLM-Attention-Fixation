import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val length = text.length / 2
        val left_half = text.substring(0, length)
        val right_half = text.substring(length).reverse
        left_half + right_half
    }
    def main(args: Array[String]) = {
    assert(f(("n")).equals(("n")));
    }

}
