import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, ch : String) : String = {
        if (!s.contains(ch)) {
            return ""
        }
        var str = s.drop(s.indexOf(ch) + 1).reverse
        for (i <- 0 until str.length) {
            str = str.drop(str.indexOf(ch) + 1).reverse
        }
        str
    }
    def main(args: Array[String]) = {
    assert(f(("shivajimonto6"), ("6")).equals(("")));
    }

}
