import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        text.toList.forall(_.isWhitespace)
    }
    def main(args: Array[String]) = {
    assert(f((" 	  　")) == (true));
    }

}
