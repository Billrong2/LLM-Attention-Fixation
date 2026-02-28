import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, prefix : String) : String = {
        val prefixLength = prefix.length()
        if (text.startsWith(prefix)) {
            return text.slice((prefixLength - 1) / 2,
                              (prefixLength + 1) / 2 * -1).reverse
        } else {
            return text
        }
    }
    def main(args: Array[String]) = {
    assert(f(("happy"), ("ha")).equals(("")));
    }

}
