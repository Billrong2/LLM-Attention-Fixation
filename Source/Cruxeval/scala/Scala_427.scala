import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        var count = s.length - 1
        var reverse_s = s.reverse
        while (count > 0 && reverse_s.sliding(2, 2).mkString("").lastIndexOf("sea") == -1) {
            count -= 1
            reverse_s = reverse_s.substring(0, count)
        }
        reverse_s.substring(count)
    }
    def main(args: Array[String]) = {
    assert(f(("s a a b s d s a a s a a")).equals(("")));
    }

}
