import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, from_c : String, to_c : String) : String = {
        val table = s.map(c => if(from_c.indexOf(c) != -1) to_c(from_c.indexOf(c)) else c)
        table.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("aphid"), ("i"), ("?")).equals(("aph?d")));
    }

}
