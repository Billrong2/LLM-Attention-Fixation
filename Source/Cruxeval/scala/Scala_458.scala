import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, search_chars : String, replace_chars : String) : String = {
        val trans_table = search_chars.zip(replace_chars).toMap
        text.map(c => trans_table.getOrElse(c, c))
    }
    def main(args: Array[String]) = {
    assert(f(("mmm34mIm"), ("mm3"), (",po")).equals(("pppo4pIp")));
    }

}
