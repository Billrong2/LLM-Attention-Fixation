import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var a = new ListBuffer[Char]()
        for (i <- 0 until text.length) {
            if (!text(i).isDigit) {
                a += text(i)
            }
        }
        a.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("seiq7229 d27")).equals(("seiq d")));
    }

}
