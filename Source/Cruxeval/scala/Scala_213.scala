import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        s.replace("(", "[").replace(")", "]")
    }
    def main(args: Array[String]) = {
    assert(f(("(ac)")).equals(("[ac]")));
    }

}
