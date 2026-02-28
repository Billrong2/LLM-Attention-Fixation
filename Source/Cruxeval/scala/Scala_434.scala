import scala.collection.mutable._
import scala.math._
object Problem {
    def f(string: String): Int = {
        try {
            string.lastIndexOf('e')
        } catch {
            case ex: NullPointerException => -1 // Return a default value like -1 if 'e' is not found
        }
    }
    def main(args: Array[String]) = {
    assert(f(("eeuseeeoehasa")) == (8l));
    }

}
