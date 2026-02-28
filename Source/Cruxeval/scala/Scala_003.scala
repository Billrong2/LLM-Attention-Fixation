import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, value : String) : String = {
        val textList = text.toList
        val updatedTextList = textList :+ value
        updatedTextList.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("bcksrut"), ("q")).equals(("bcksrutq")));
    }

}
