import scala.math._
import scala.collection.mutable._
object Problem {
    def f(key : String, value : String) : (String, String) = {
        val dict = Map(key -> value)
        dict.head
    }
    def main(args: Array[String]) = {
    assert(f(("read"), ("Is")).equals((("read", "Is"))));
    }

}
