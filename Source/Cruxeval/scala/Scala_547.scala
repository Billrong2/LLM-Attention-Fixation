import scala.math._
import scala.collection.mutable._
object Problem {
    def f(letters : String) : String = {
        val lettersOnly = letters.stripPrefix(".").stripSuffix(",").stripPrefix(" ").stripSuffix("!?").stripSuffix("*")
        lettersOnly.split(" ").mkString("....")
    }
    def main(args: Array[String]) = {
    assert(f(("h,e,l,l,o,wo,r,ld,")).equals(("h,e,l,l,o,wo,r,ld")));
    }

}
