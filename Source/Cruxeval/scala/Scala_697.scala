import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, sep : String) : (String, String, String) = {
        val sep_index = s.indexOf(sep)
        val prefix = if (sep_index == -1) s else s.substring(0, sep_index)
        val middle = if (sep_index == -1) "" else s.substring(sep_index, sep_index + sep.length)
        val right_str = if (sep_index == -1) "" else s.substring(sep_index + sep.length)
        (prefix, middle, right_str)
    }
    def main(args: Array[String]) = {
    assert(f(("not it"), ("")).equals((("", "", "not it"))));
    }

}
