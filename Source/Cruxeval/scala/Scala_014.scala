import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        val arr = s.trim.reverse
        return arr
    }
    def main(args: Array[String]) = {
    assert(f(("   OOP   ")).equals(("POO")));
    }

}
