import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, position : Long, value : String) : String = {
        val length = text.length()
        val index = (position % (length + 2)).toInt - 1
        if (index >= length || index < 0) {
            return text
        }
        val textList = text.toList
        textList.updated(index, value).mkString
    }
    def main(args: Array[String]) = {
    assert(f(("1zd"), (0l), ("m")).equals(("1zd")));
    }

}
