import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        val vowels = "aeiou"
        val maxIndex = vowels.map(ch => text.indexOf(ch)).max
        maxIndex
    }
    def main(args: Array[String]) = {
    assert(f(("qsqgijwmmhbchoj")) == (13l));
    }

}
