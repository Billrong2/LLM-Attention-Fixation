import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        val Array(string_a, string_b) = text.split(",")
        return -(string_a.length + string_b.length)
    }
    def main(args: Array[String]) = {
    assert(f(("dog,cat")) == (-6l));
    }

}
