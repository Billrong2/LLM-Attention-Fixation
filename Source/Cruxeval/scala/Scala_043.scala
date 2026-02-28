import scala.math._
import scala.collection.mutable._
object Problem {
    def f(n : String) : Long = {
        val result = n.forall(_.isDigit)
        if (result) n.toLong else -1
    }
    def main(args: Array[String]) = {
    assert(f(("6 ** 2")) == (-1l));
    }

}
