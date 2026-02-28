import scala.collection.mutable._
import scala.math._
object Problem {
    def f(n : String) : String = {
        val length = n.length + 2
        val revn = n.toList
        val result = revn.mkString
        val newRevn = List[Char]()
        result + "!" * length
    }
    def main(args: Array[String]) = {
    assert(f(("iq")).equals(("iq!!!!")));
    }

}
