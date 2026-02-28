import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, separator : String) : String = {
        for (i <- 0 until s.length) {
            if (s.charAt(i) == separator.charAt(0)) {
                var new_s = s.toList
                new_s = new_s.updated(i, '/')
                return new_s.mkString(" ")
            }
        }
        throw new IllegalArgumentException("Separator not found in the given string")
    }
    def main(args: Array[String]) = {
    assert(f(("h grateful k"), (" ")).equals(("h / g r a t e f u l   k")));
    }

}
