import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, new_ending : String) : String = {
        val result = text.toList
        val extendedResult = result ++ new_ending
        extendedResult.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("jro"), ("wdlp")).equals(("jrowdlp")));
    }

}
