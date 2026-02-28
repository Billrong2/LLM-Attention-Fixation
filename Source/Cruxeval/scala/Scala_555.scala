import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, tabstop : Long) : String = {
        var result = text.replace("\n", "_____")
        result = result.replace("\t", " " * tabstop.toInt)
        result = result.replace("_____", "\n")
        return result
    }
    def main(args: Array[String]) = {
    assert(f(("odes	code	well"), (2l)).equals(("odes  code  well")));
    }

}
