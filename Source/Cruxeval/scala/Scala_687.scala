import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val t = text.toList
        val midIndex = t.size / 2
        val t1 = t.take(midIndex) ++ t.drop(midIndex + 1)
        val t2 = t1 :+ text.toLowerCase
        t2.mkString(":")
    }
    def main(args: Array[String]) = {
    assert(f(("Rjug nzufE")).equals(("R:j:u:g: :z:u:f:E:rjug nzufe")));
    }

}
