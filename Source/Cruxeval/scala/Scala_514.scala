import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var result = text
        text.split(" ").foreach { item =>
            result = result.replace(s"-$item", " ").replace(s"$item-", " ")
        }
        result.stripPrefix("-").stripSuffix("-")
    }
    def main(args: Array[String]) = {
    assert(f(("-stew---corn-and-beans-in soup-.-")).equals(("stew---corn-and-beans-in soup-.")));
    }

}
