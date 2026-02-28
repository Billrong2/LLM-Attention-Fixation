import scala.collection.mutable._
import scala.math._
object Problem {
    def f(name: String): List[String] = {
        List(name(0).toString, name(1).toString.reverse(0).toString)
    }
    def main(args: Array[String]) = {
    assert(f(("master. ")).equals((List[String]("m", "a"))));
    }

}
