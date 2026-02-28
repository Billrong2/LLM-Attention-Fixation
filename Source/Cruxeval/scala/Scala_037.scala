import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : List[String] = {
        var text_arr = ListBuffer[String]()
        for (j <- 0 until text.length) {
            text_arr += text.substring(j)
        }
        text_arr.toList
    }
    def main(args: Array[String]) = {
    assert(f(("123")).equals((List[String]("123", "23", "3"))));
    }

}
