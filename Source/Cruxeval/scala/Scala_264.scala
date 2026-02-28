import scala.math._
import scala.collection.mutable._
object Problem {
    def f(test_str : String) : String = {
        val s = test_str.replace('a', 'A')
        s.replace('e', 'A')
    }
    def main(args: Array[String]) = {
    assert(f(("papera")).equals(("pApArA")));
    }

}
