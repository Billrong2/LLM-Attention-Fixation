import scala.math._
import scala.collection.mutable._
object Problem {
    def f(seq : List[String], v : String) : List[String] = {
        var a = ListBuffer[String]()
        for (i <- seq) {
            if (i.endsWith(v)) {
                a += i + i
            }
        }
        a.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("oH", "ee", "mb", "deft", "n", "zz", "f", "abA")), ("zz")).equals((List[String]("zzzz"))));
    }

}
