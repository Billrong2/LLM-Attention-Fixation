import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[String]) : String = {
        if(array.length == 1) {
            return array.mkString("")
        }
        var result = array.toArray
        var i = 0
        while (i < array.length - 1) {
            for (_ <- 0 until 2) {
                result(i * 2) = array(i)
                i += 1
            }
        }
        result.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("ac8", "qk6", "9wg"))).equals(("ac8qk6qk6")));
    }

}
