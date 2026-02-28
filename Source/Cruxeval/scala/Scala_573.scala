import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String, prefix : String) : String = {
        if(string.startsWith(prefix)) {
            return string.stripPrefix(prefix)
        } else {
            return string
        }
    }
    def main(args: Array[String]) = {
    assert(f(("Vipra"), ("via")).equals(("Vipra")));
    }

}
