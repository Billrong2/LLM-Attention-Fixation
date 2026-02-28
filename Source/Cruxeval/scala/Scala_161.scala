import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, value : String) : String = {
        val parts = text.split(value, 2)
        parts(1) + parts(0)
    }
    def main(args: Array[String]) = {
    assert(f(("difkj rinpx"), ("k")).equals(("j rinpxdif")));
    }

}
