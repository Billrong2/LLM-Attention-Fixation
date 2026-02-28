import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, n : Long, c : String) : String = {
        var result = s
        val width = c.length * n
        for (_ <- 0L until (width - s.length)) {
            result = c + result
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("."), (0l), ("99")).equals((".")));
    }

}
