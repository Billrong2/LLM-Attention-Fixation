import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : Boolean = {
        if (text.contains(char)) {
            val textList = text.split(char).map(_.trim).filter(_.nonEmpty)
            if (textList.length > 1) {
                return true
            }
        }
        false
    }
    def main(args: Array[String]) = {
    assert(f(("only one line"), (" ")) == (true));
    }

}
