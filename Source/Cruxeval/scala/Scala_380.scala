import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, delimiter : String) : String = {
        val text_list = text.split(delimiter)
        val start = text_list.slice(0, text_list.length-1).mkString(delimiter)
        val end = text_list.last
        start + delimiter + end
    }
    def main(args: Array[String]) = {
    assert(f(("xxjarczx"), ("x")).equals(("xxjarcz")));
    }

}
