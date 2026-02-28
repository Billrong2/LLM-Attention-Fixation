import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : List[String], b : String) : List[String] = {
        val str = a.mkString(b)
        var lst: ListBuffer[String] = ListBuffer()
        for (i <- 1 to str.length by 2) {
            lst += str.slice(i-1, i-1+i)
            lst += str.slice(i-1+i, str.length)
        }
        lst.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("a", "b", "c")), (" ")).equals((List[String]("a", " b c", "b c", "", "c", ""))));
    }

}
