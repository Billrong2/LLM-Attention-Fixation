import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, sep : String) : String = {
        val reverse = s.split(sep).map(e => "*" + e).reverse
        reverse.mkString(";")
    }
    def main(args: Array[String]) = {
    assert(f(("volume"), ("l")).equals(("*ume;*vo")));
    }

}
