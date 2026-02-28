import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s1 : String, s2 : String) : Long = {
        var position = 1
        var count = 0
        while (position > 0) {
            position = s1.indexOf(s2, position)
            count += 1
            position += 1
        }
        count
    }
    def main(args: Array[String]) = {
    assert(f(("xinyyexyxx"), ("xx")) == (2l));
    }

}
