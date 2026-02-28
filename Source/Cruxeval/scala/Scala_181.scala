import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : (String, Long) = {
        var count = 0
        var digits = ""
        for (c <- s) {
            if (c.isDigit) {
                count += 1
                digits += c
            }
        }
        (digits, count)
    }
    def main(args: Array[String]) = {
    assert(f(("qwfasgahh329kn12a23")).equals((("3291223", 7l))));
    }

}
