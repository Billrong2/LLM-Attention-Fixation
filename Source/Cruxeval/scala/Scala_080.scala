import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        s.trim.reverse
    }
    def main(args: Array[String]) = {
    assert(f(("ab        ")).equals(("ba")));
    }

}
