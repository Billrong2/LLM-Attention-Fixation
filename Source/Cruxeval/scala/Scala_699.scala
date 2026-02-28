import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, elem : String) : List[String] = {
        var t = text
        var e = elem
        if (e != "") {
            while (t.startsWith(e)) {
                t = t.replaceFirst(e, "")
            }
            while (e.startsWith(t)) {
                e = e.replaceFirst(t, "")
            }
        }
        List(e, t)
    }
    def main(args: Array[String]) = {
    assert(f(("some"), ("1")).equals((List[String]("1", "some"))));
    }

}
