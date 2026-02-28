import scala.math._
import scala.collection.mutable._
object Problem {
    def f(items : List[String], target : String) : Long = {
        if (items.contains(target)) {
            return items.indexOf(target).toLong
        } else {
            return -1
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("1", "+", "-", "**", "//", "*", "+")), ("**")) == (3l));
    }

}
