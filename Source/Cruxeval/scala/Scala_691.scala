import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, suffix : String) : String = {
        if (suffix.nonEmpty && suffix.last.toString.contains(suffix.last)) {
            f(text.stripSuffix(suffix.last.toString), suffix.dropRight(1))
        } else {
            text
        }
    }
    def main(args: Array[String]) = {
    assert(f(("rpyttc"), ("cyt")).equals(("rpytt")));
    }

}
