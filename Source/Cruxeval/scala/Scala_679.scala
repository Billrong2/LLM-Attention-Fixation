import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        if (text.isEmpty) {
            false
        } else {
            val firstChar = text.head
            if (firstChar.isDigit) {
                false
            } else {
                for (lastChar <- text) {
                    if (lastChar != '_' && !lastChar.isLetterOrDigit) {
                        false
                    }
                }
                true
            }
        }
    }
    def main(args: Array[String]) = {
    assert(f(("meet")) == (true));
    }

}
