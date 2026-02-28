import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : String, b : String, c : String, d : String) : String = {
        if (a != null && b != null) {
            return b
        } else if (c != null && d != null) {
            return d
        } else {
            return null
        }
    }
    def main(args: Array[String]) = {
    assert(f(("CJU"), ("BFS"), ("WBYDZPVES"), ("Y")).equals(("BFS")));
    }

}
