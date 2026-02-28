import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String, char: String): String = {
        if (text.contains(char)) {
            val (suff, rest) = text.span(_ != char.charAt(0))
            val (charFound, pref) = rest.splitAt(char.length)
            val newPref = suff.dropRight(char.length) + suff.drop(char.length) + char + pref
            return suff + char + newPref
        }
        text
    }
    def main(args: Array[String]) = {
    assert(f(("uzlwaqiaj"), ("u")).equals(("uuzlwaqiaj")));
    }

}
