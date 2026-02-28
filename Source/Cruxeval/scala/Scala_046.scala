import scala.math._
import scala.collection.mutable._
object Problem {
    def f(l : List[String], c : String) : String = {
        l.mkString(c)
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("many", "letters", "asvsz", "hello", "man")), ("")).equals(("manylettersasvszhelloman")));
    }

}
