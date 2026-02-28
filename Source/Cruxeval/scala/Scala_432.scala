import scala.math._
import scala.collection.mutable._
object Problem {
    def f(length : Long, text : String) : Any = {
        if (text.length == length) {
            text.reverse
        } else {
            false
        }
    }
    def main(args: Array[String]) = {
    assert(f((-5l), ("G5ogb6f,c7e.EMm")).equals(false));
    }

}
