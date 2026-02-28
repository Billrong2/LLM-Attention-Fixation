import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        val punctuations = List(".", "!", "?")
        punctuations.exists(text.endsWith)
    }
    def main(args: Array[String]) = {
    assert(f((". C.")) == (true));
    }

}
