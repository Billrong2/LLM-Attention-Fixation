import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val textList = text.toList.map(_.toString)
        val updatedTextList = textList.zipWithIndex.map { case (char, i) => if (char == char.toUpperCase) char.toLowerCase else char.toUpperCase }
        updatedTextList.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("akA?riu")).equals(("AKa?RIU")));
    }

}
