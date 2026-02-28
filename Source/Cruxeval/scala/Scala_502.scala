import scala.math._
import scala.collection.mutable._
object Problem {
    def f(name : String) : String = {
        name.split(" ").mkString("*")
    }
    def main(args: Array[String]) = {
    assert(f(("Fred Smith")).equals(("Fred*Smith")));
    }

}
