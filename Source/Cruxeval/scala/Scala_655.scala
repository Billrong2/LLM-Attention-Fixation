import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        s.replaceAll("a", "").replaceAll("r", "")
    }
    def main(args: Array[String]) = {
    assert(f(("rpaar")).equals(("p")));
    }

}
