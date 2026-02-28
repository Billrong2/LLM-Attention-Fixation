import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val myList = text.split(" ")
        val sortedList = myList.sorted.reverse
        sortedList.mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f(("a loved")).equals(("loved a")));
    }

}
