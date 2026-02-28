import scala.math._
import scala.collection.mutable._
object Problem {
    def f(txt : String, sep : String, sep_count : Long) : String = {
        var o = ""
        var tempTxt = txt
        var count = sep_count

        while (count > 0 && tempTxt.count(_ == sep) > 0) {
            val sepIndex = tempTxt.lastIndexOf(sep)
            o += tempTxt.substring(0, sepIndex + 1)
            tempTxt = tempTxt.substring(sepIndex + 1)
            count -= 1
        }

        o + tempTxt
    }
    def main(args: Array[String]) = {
    assert(f(("i like you"), (" "), (-1l)).equals(("i like you")));
    }

}
