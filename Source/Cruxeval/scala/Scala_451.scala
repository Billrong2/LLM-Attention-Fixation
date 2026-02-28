import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : String = {
        var textList = text.toList
        for ((item, index) <- textList.zipWithIndex) {
            if (item.toString == char) {
                textList = textList.patch(index, Nil, 1)
                return textList.mkString
            }
        }
        textList.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("pn"), ("p")).equals(("n")));
    }

}
