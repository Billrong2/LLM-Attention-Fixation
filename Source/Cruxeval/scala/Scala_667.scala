import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : List[String] = {
        var new_text = ListBuffer[String]()
        for (i <- 0 until text.length / 3) {
            new_text += s"< ${text.substring(i * 3, i * 3 + 3)} level=$i >"
        }
        val last_item = text.substring(text.length / 3 * 3)
        new_text += s"< $last_item level=${text.length / 3} >"
        new_text.toList
    }
    def main(args: Array[String]) = {
    assert(f(("C7")).equals((List[String]("< C7 level=0 >"))));
    }

}
