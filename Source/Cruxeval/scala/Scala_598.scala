import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, n : Long) : String = {
        val length = text.length
        text.substring(length * (n % 4).toInt, length)
    }
    def main(args: Array[String]) = {
    assert(f(("abc"), (1l)).equals(("")));
    }

}
