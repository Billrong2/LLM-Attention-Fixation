import scala.math._
import scala.collection.mutable._
object Problem {
    def f(value : String) : String = {
        val ls = value.toList :+ "NHIB"
        ls.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("ruam")).equals(("ruamNHIB")));
    }

}
