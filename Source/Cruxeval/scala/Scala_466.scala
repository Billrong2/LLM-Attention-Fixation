import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val length = text.length
        var index = 0
        while (index < length && text.charAt(index).isWhitespace) {
            index += 1
        }
        text.substring(index, index + 5)
    }
    def main(args: Array[String]) = {
    assert(f(("-----	\n	th\n-----")).equals(("-----")));
    }

}
