import scala.math._
import scala.collection.mutable._
object Problem {
    def f(haystack : String, needle : String) : Long = {
        for (i <- haystack.indexOf(needle) to 0 by -1) {
            if (haystack.substring(i) == needle) {
                return i
            }
        }
        return -1
    }
    def main(args: Array[String]) = {
    assert(f(("345gerghjehg"), ("345")) == (-1l));
    }

}
