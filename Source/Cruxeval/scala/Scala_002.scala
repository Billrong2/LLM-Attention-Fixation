import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var new_text = text.toList
        for (i <- "+") {
            if (new_text.contains(i)) {
                new_text = new_text.filter(_ != i)
            }
        }
        new_text.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("hbtofdeiequ")).equals(("hbtofdeiequ")));
    }

}
