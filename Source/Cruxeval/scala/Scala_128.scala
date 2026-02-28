import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var odd = ""
        var even = ""
        for (i <- 0 until text.length) {
            if (i % 2 == 0) {
                even += text(i)
            } else {
                odd += text(i)
            }
        }
        even + odd.toLowerCase()
    }
    def main(args: Array[String]) = {
    assert(f(("Mammoth")).equals(("Mmohamt")));
    }

}
