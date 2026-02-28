import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String) : String = {
        var tmp = string.toLowerCase
        for (char <- string.toLowerCase) {
            if (tmp.contains(char)) {
                tmp = tmp.replaceFirst(s"\\Q$char\\E", "")
            }
        }
        tmp
    }
    def main(args: Array[String]) = {
    assert(f(("[ Hello ]+ Hello, World!!_ Hi")).equals(("")));
    }

}
