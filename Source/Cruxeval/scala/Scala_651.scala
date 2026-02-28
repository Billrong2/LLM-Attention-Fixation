import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, letter : String) : String = {
        val updatedLetter = if (letter.charAt(0).isLower) letter.toUpperCase else letter
        val updatedText = text.map(char => if (char.toLower == letter.toLowerCase) updatedLetter else char)
        updatedText.mkString.capitalize
    }
    def main(args: Array[String]) = {
    assert(f(("E wrestled evil until upperfeat"), ("e")).equals(("E wrestled evil until upperfeat")));
    }

}
