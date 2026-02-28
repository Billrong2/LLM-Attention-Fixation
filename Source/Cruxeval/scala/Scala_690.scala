import scala.math._
import scala.collection.mutable._
object Problem {
    def f(n : String) : String = {
        if (n.contains('.')) {
            return (n.toDouble + 2.5).toString
        }
        return n
    }
    def main(args: Array[String]) = {
    assert(f(("800")).equals(("800")));
    }

}
