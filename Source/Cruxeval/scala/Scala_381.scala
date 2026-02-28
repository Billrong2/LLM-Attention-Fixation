import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, num_digits : Long) : String = {
        val width = max(1, num_digits.toInt)
        text.reverse.padTo(width, '0').reverse.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("19"), (5l)).equals(("00019")));
    }

}
