import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, c : String) : String = {
        val words = s.split(" ")
        return c + "  " + words.reverse.mkString("  ")
    }
    def main(args: Array[String]) = {
    assert(f(("Hello There"), ("*")).equals(("*  There  Hello")));
    }

}
