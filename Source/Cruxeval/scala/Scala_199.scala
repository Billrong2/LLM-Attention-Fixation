import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, char : String) : String = {
        val base = char * (s.count(_ == char.charAt(0)) + 1)
        return s.stripSuffix(base)
    }
    def main(args: Array[String]) = {
    assert(f(("mnmnj krupa...##!@#!@#$$@##"), ("@")).equals(("mnmnj krupa...##!@#!@#$$@##")));
    }

}
