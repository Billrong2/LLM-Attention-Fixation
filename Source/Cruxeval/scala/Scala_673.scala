import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String) : String = {
        if(string == string.toUpperCase()) {
            return string.toLowerCase()
        } else if(string == string.toLowerCase()) {
            return string.toUpperCase()
        } else {
            return string
        }
    }
    def main(args: Array[String]) = {
    assert(f(("cA")).equals(("cA")));
    }

}
