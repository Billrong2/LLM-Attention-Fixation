import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        text.replace("\n", "\t")
    }
    def main(args: Array[String]) = {
    assert(f(("apples\n	\npears\n	\nbananas")).equals(("apples			pears			bananas")));
    }

}
