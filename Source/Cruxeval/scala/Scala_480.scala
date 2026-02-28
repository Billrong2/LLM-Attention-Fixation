import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, c1 : String, c2 : String) : String = {
        if (s == "") {
            s
        } else {
            val ls = s.split(c1)
            for ((item, index) <- ls.zipWithIndex) {
                if (item.contains(c1)) {
                    ls(index) = item.replaceFirst(c1, c2)
                }
            }
            ls.mkString(c1)
        }
    }
    def main(args: Array[String]) = {
    assert(f((""), ("mi"), ("siast")).equals(("")));
    }

}
