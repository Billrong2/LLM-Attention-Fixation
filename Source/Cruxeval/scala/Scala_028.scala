import scala.math._
import scala.collection.mutable._
object Problem {
    def f(mylist : List[Long]) : Boolean = {
        val revl = mylist.reverse
        val sortedList = mylist.sorted.reverse
        sortedList == revl
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](5l.toLong, 8l.toLong))) == (true));
    }

}
