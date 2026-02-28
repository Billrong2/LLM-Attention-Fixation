import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        for(i <- 0 until text.length) {
            if (text.substring(0, i).startsWith("two")) {
                return text.substring(i)
            }
        }
        return "no"
    }
    def main(args: Array[String]) = {
    assert(f(("2two programmers")).equals(("no")));
    }

}
