import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, m : Long, n : Long) : String = {
        val text_extended = text + text.slice(0, m.toInt) + text.slice(n.toInt, text.length)
        var result = ""
        for (i <- n.toInt until text_extended.length - m.toInt) {
            result = text_extended.charAt(i) + result
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("abcdefgabc"), (1l), (2l)).equals(("bagfedcacbagfedc")));
    }

}
