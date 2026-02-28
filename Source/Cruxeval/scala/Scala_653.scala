import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, letter : String) : Long = {
        var t = text
        for (alph <- text) {
            t = t.replaceAll(alph.toString, "")
        }
        t.split(letter).length
    }
    def main(args: Array[String]) = {
    assert(f(("c, c, c ,c, c"), ("c")) == (1l));
    }

}
