import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        var s = 0
        for (i <- 1 until text.length) {
            s += text.split(text(i))(0).length
        }
        s
    }
    def main(args: Array[String]) = {
    assert(f(("wdj")) == (3l));
    }

}
