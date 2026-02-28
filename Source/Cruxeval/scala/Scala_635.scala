import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        val validChars = List('-', '_', '+', '.', '/', ' ')
        val upperText = text.toUpperCase()
        for (char <- upperText) {
            if (!char.isLetterOrDigit && !validChars.contains(char)) {
                return false
            }
        }
        true
    }
    def main(args: Array[String]) = {
    assert(f(("9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW")) == (false));
    }

}
