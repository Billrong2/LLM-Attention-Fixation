import scala.math._
import scala.collection.mutable._
object Problem {
    def f(n : String, s : String) : String = {
        if (s.startsWith(n)) {
            val parts = s.split(n, 2)
            val pre = parts(0)
            return pre + n + s.substring(n.length)
        }
        s
    }
    def main(args: Array[String]) = {
    assert(f(("xqc"), ("mRcwVqXsRDRb")).equals(("mRcwVqXsRDRb")));
    }

}
