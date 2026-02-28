import scala.collection.mutable.ListBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String): String = {
        var textList = text.toList
        val updatedText = ListBuffer[Char]()

        for (i <- textList.length - 1 to 0 by -1) {
            if (textList(i).isWhitespace) {
                updatedText += '&'
                updatedText += 'n'
                updatedText += 'b'
                updatedText += 's'
                updatedText += 'p'
                updatedText += ';'
            } else {
                updatedText += textList(i)
            }
        }

        updatedText.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("   ")).equals(("&nbsp;&nbsp;&nbsp;")));
    }

}
