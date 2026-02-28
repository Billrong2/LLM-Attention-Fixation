import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var out = ""
        for (i <- 0 until text.length) {
            if (text(i).isUpper) {
                out += text(i).toLower
            } else {
                out += text(i).toUpper
            }
        }
        out
    }
    def main(args: Array[String]) = {
    assert(f((",wPzPppdl/")).equals((",WpZpPPDL/")));
    }

}
