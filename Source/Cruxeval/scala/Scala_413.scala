import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        s.slice(3, s.length) + s.slice(2, 3) + s.slice(5, 8)
    }
    def main(args: Array[String]) = {
    assert(f(("jbucwc")).equals(("cwcuc")));
    }

}
