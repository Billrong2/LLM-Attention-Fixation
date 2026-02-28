import scala.collection.mutable._
import scala.math._
object Problem {
    def f(st: String): String = {
        var swapped = ""
        for (ch <- st.reverse) {
            swapped = swapped.concat(if (ch.isUpper) ch.toLower.toString else ch.toUpper.toString)
        }
        swapped
    }
    def main(args: Array[String]) = {
    assert(f(("RTiGM")).equals(("mgItr")));
    }

}
