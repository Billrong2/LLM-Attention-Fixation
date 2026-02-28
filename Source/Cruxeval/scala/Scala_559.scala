import scala.math._
import scala.collection.mutable._
object Problem {
    def f(n : String) : String = {
        val strN = n.toString
        strN(0) + "." + strN.substring(1).replace("-", "_")
    }
    def main(args: Array[String]) = {
    assert(f(("first-second-third")).equals(("f.irst_second_third")));
    }

}
