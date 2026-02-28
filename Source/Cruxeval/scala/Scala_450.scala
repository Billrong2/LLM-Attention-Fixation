import scala.math._
import scala.collection.mutable._
object Problem {
    def f(strs : String) : String = {
        var words = strs.split(" ")
        for (i <- 1 until words.length by 2) {
            words(i) = words(i).reverse
        }
        words.mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f(("K zBK")).equals(("K KBz")));
    }

}
