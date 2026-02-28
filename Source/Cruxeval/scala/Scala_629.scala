import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, dng : String) : String = {
        if (!text.contains(dng)) {
            text
        } else if (text.takeRight(dng.length) == dng) {
            text.dropRight(dng.length)
        } else {
            text.dropRight(1) + f(text.dropRight(2), dng)
        }
    }
    def main(args: Array[String]) = {
    assert(f(("catNG"), ("NG")).equals(("cat")));
    }

}
