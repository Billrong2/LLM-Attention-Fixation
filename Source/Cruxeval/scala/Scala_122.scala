import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String) : String = {
        if (string.take(4) != "Nuva") {
            return "no"
        } else {
            return string.trim()
        }
    }
    def main(args: Array[String]) = {
    assert(f(("Nuva?dlfuyjys")).equals(("Nuva?dlfuyjys")));
    }

}
