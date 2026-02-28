import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String) : String = {
        var str = string
        while (str.nonEmpty) {
            if (str.last.isLetter) {
                return str
            }
            str = str.dropRight(1)
        }
        str
    }
    def main(args: Array[String]) = {
    assert(f(("--4/0-209")).equals(("")));
    }

}
