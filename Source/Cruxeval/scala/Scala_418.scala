import scala.collection.mutable._
import scala.math._
object Problem {
    def f(s: String, p: String): String = {
        val index = s.indexOf(p)
        if (index >= 0) {
            val (part_one, part_two, part_three) = (s.substring(0, index).length, p.length, s.substring(index + p.length).length)
            if (part_one >= 2 && part_two <= 2 && part_three >= 2) {
                s.substring(0, index).reverse + p + s.substring(index + p.length).reverse + "#"
            } else {
                s
            }
        } else {
            s
        }
    }
    def main(args: Array[String]) = {
    assert(f(("qqqqq"), ("qqq")).equals(("qqqqq")));
    }

}
