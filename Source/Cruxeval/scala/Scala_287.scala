import scala.math._
import scala.collection.mutable._
object Problem {
    def f(name : String) : String = {
        if (name.forall(_.isLower)) name.toUpperCase
        else name.toLowerCase
    }
    def main(args: Array[String]) = {
    assert(f(("Pinneaple")).equals(("pinneaple")));
    }

}
