import scala.math._
import scala.collection.mutable._
object Problem {
    def f(total : List[String], arg : String) : List[String] = {
        arg.map(_.toString).toList match {
            case x :: xs => total ::: (x :: xs)
            case _ => total ::: arg.map(_.toString).toList
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("1", "2", "3")), ("nammo")).equals((List[String]("1", "2", "3", "n", "a", "m", "m", "o"))));
    }

}
