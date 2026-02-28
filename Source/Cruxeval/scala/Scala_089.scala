import scala.math._
import scala.collection.mutable._
object Problem {
    def f(char : String) : String = {
        if (!"aeiouAEIOU".contains(char)) {
            return null
        } else if ("AEIOU".contains(char)) {
            return char.toLowerCase()
        } else {
            return char.toUpperCase()
        }
    }
    def main(args: Array[String]) = {
    assert(f(("o")).equals(("O")));
    }

}
