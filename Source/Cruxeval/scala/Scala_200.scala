import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, value : String) : String = {
        var length = text.length
        var index = 0
        var result = value
        while (length > 0) {
            result = text.charAt(index) + result
            length -= 1
            index += 1
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("jao mt"), ("house")).equals(("tm oajhouse")));
    }

}
