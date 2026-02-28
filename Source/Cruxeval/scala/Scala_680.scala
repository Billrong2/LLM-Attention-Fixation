import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var letters = ""
        for (i <- 0 until text.length) {
            if (text(i).isLetterOrDigit) {
                letters += text(i)
            }
        }
        letters
    }
    def main(args: Array[String]) = {
    assert(f(("we@32r71g72ug94=(823658*!@324")).equals(("we32r71g72ug94823658324")));
    }

}
