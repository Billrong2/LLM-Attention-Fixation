import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, tab_size : Long) : String = {
        var res = ""
        var modifiedText = text.replaceAll("\t", " " * (tab_size.toInt - 1))
        for (i <- 0 until modifiedText.length) {
            if (modifiedText(i) == ' ') {
                res += "|"
            } else {
                res += modifiedText(i)
            }
        }
        res
    }
    def main(args: Array[String]) = {
    assert(f(("	a"), (3l)).equals(("||a")));
    }

}
