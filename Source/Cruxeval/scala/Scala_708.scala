import scala.collection.mutable._
import scala.math._
object Problem {
    def f(string: String): String = {
        var l = string.toList
        var foundNonSpace = false
        for (i <- l.length - 1 to 0 by -1 if !foundNonSpace) {
            if (l(i) != ' ') {
                foundNonSpace = true
            }
            if (!foundNonSpace) {
                l = l.patch(i, Nil, 1)
            }
        }
        l.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("    jcmfxv     ")).equals(("    jcmfxv")));
    }

}
