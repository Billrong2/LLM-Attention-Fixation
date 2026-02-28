import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, sub : String) : List[Long] = {
        var index = ListBuffer[Long]()
        var starting = 0
        while (starting != -1) {
            starting = text.indexOf(sub, starting)
            if (starting != -1) {
                index += starting
                starting += sub.length
            }
        }
        index.toList
    }
    def main(args: Array[String]) = {
    assert(f(("egmdartoa"), ("good")).equals((List[Long]())));
    }

}
