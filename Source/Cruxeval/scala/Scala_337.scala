import scala.math._
import scala.collection.mutable._
object Problem {
    def f(txt : String) : String = {
        var result = new ListBuffer[Char]()
        for (c <- txt) {
            if (Character.isDigit(c)) {
                // do nothing
            } else if (Character.isLowerCase(c)) {
                result += Character.toUpperCase(c)
            } else if (Character.isUpperCase(c)) {
                result += Character.toLowerCase(c)
            }
        }
        result.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("5ll6")).equals(("LL")));
    }

}
