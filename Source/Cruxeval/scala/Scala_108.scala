import scala.math._
import scala.collection.mutable._

object Problem {
    def f(input : Any) : Long = {
        var amount: Long = 0
        var nonzero: Long = 0
        input match {
            case v: List[Any] => amount = v.length
            case v: Map[Any, Any] => amount = v.keys.size
            case _ => amount = 0
        }
        nonzero = if (amount > 0) amount else 0
        nonzero
    }
    def main(args: Array[String]) = {
    assert(f((1l)) == (0l));
    }

}
