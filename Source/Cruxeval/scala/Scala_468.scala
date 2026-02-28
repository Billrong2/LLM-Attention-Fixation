import scala.collection.mutable._
import scala.math._
object Problem {
    def f(a : String, b : String, n : Long) : String = {
        var result = b
        var m = b
        var mutableA = a
        for (_ <- 0 until n.toInt) {
            if (m.nonEmpty) {
                val index = mutableA.indexOf(m)
                if (index != -1) {
                    val (prefix, suffix) = mutableA.splitAt(index)
                    mutableA = prefix + suffix.drop(m.length)
                    m = ""
                    result = b
                } else {
                    m = ""
                }
            }
        }
        mutableA.split(b).mkString(result)
    }
    def main(args: Array[String]) = {
    assert(f(("unrndqafi"), ("c"), (2l)).equals(("unrndqafi")));
    }

}
