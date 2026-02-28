import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : List[Long] = {
        var new_text = text
        var a = ListBuffer[Long]()
        while (new_text.contains(char)) {
            a += new_text.indexOf(char)
            new_text = new_text.replaceFirst(char, "")
        }
        a.toList
    }
    def main(args: Array[String]) = {
    assert(f(("rvr"), ("r")).equals((List[Long](0l.toLong, 1l.toLong))));
    }

}
