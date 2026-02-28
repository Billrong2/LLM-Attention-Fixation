import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, amount : Long) : String = {
        val length: Int = text.length
        var pre_text: String = "|"
        if (amount >= length) {
            val extra_space: Int = (amount - length).toInt
            pre_text += " " * (extra_space / 2)
            return pre_text + text + pre_text
        }
        return text
    }
    def main(args: Array[String]) = {
    assert(f(("GENERAL NAGOOR"), (5l)).equals(("GENERAL NAGOOR")));
    }

}
