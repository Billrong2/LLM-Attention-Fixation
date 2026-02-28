import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val lowercaseText = text.toLowerCase()
        val (head, tail) = (lowercaseText.head, lowercaseText.tail)
        head.toUpper + tail
    }
    def main(args: Array[String]) = {
    assert(f(("Manolo")).equals(("Manolo")));
    }

}
