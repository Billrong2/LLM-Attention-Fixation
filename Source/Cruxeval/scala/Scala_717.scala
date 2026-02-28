import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var k = 0
        var l = text.length - 1
        while (!text.charAt(l).isLetter) {
            l -= 1
        }
        while (!text.charAt(k).isLetter) {
            k += 1
        }
        if (k != 0 || l != text.length - 1) {
            return text.substring(k, l+1)
        } else {
            return text.substring(0, 1)
        }
    }
    def main(args: Array[String]) = {
    assert(f(("timetable, 2mil")).equals(("t")));
    }

}
