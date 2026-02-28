import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, num : Long) : String = {
        val req = (num - text.length).toInt / 2
        val centeredText = text.padTo(num.toInt, '*').mkString
        centeredText.substring(req, centeredText.length - req)
    }
    def main(args: Array[String]) = {
    assert(f(("a"), (19l)).equals(("*")));
    }

}
