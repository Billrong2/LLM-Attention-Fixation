import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, prefix : String) : String = {
        var t = text
        while (t.startsWith(prefix)) {
            t = t.drop(prefix.length)
            if (t.isEmpty) return text
        }
        t
    }
    def main(args: Array[String]) = {
    assert(f(("ndbtdabdahesyehu"), ("n")).equals(("dbtdabdahesyehu")));
    }

}
