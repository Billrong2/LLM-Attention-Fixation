import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, sep : String) : String = {
        val newString = s + sep
        newString.reverse.split(sep.reverse, 2)(1).reverse
    }
    def main(args: Array[String]) = {
    assert(f(("234dsfssdfs333324314"), ("s")).equals(("234dsfssdfs333324314")));
    }

}
