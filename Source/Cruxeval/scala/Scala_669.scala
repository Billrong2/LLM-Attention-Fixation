import scala.math._
import scala.collection.mutable._
object Problem {
    def f(t : String) : String = {
        val parts = t.split("-")
        val a = parts.init.mkString("-")
        val b = parts.last
        if (b.length == a.length) {
            return "imbalanced"
        }
        return a + b.replace("-", "")
    }
    def main(args: Array[String]) = {
    assert(f(("fubarbaz")).equals(("fubarbaz")));
    }

}
