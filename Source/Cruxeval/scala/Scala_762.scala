import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val lowercaseText = text.toLowerCase()
        val capitalizedText = lowercaseText.capitalize
        return lowercaseText.charAt(0) + capitalizedText.substring(1)
    }
    def main(args: Array[String]) = {
    assert(f(("this And cPanel")).equals(("this and cpanel")));
    }

}
