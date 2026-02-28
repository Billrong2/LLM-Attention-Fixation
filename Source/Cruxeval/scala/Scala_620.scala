import scala.math._
import scala.collection.mutable._
object Problem {
    def f(x : String) : String = {
        x.reverse.mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f(("lert dna ndqmxohi3")).equals(("3 i h o x m q d n   a n d   t r e l")));
    }

}
