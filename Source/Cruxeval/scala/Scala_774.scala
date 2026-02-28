import scala.math._
import scala.collection.mutable._
object Problem {
    def f(num : Long, name : String) : String = {
        f"quiz leader = $name, count = $num"
    }
    def main(args: Array[String]) = {
    assert(f((23l), ("Cornareti")).equals(("quiz leader = Cornareti, count = 23")));
    }

}
