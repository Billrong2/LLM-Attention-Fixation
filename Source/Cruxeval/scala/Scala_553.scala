import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, count : Long) : String = {
        var reversedText = text
        for (_ <- 0 until count.toInt) {
            reversedText = reversedText.reverse
        }
        reversedText
    }
    def main(args: Array[String]) = {
    assert(f(("439m2670hlsw"), (3l)).equals(("wslh0762m934")));
    }

}
