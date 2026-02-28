import scala.math._
import scala.collection.mutable._
object Problem {
    def f(r : String, w : String) : List[String] = {
        var a = List[String]()
        if (r.charAt(0) == w.charAt(0) && w.charAt(w.length - 1) == r.charAt(r.length - 1)) {
            a = a :+ r
            a = a :+ w
        } else {
            a = a :+ w
            a = a :+ r
        }
        return a
    }
    def main(args: Array[String]) = {
    assert(f(("ab"), ("xy")).equals((List[String]("xy", "ab"))));
    }

}
