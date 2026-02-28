import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, amount : Long) : String = {
        val zRepeated = "z" * (amount.toInt - s.length)
        return zRepeated + s
    }
    def main(args: Array[String]) = {
    assert(f(("abc"), (8l)).equals(("zzzzzabc")));
    }

}
