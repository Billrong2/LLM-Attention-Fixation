import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val values = text.split(" ")
        "${first}y, ${second}x, ${third}r, ${fourth}p".format(
            "first" -> values(0),
            "second" -> values(1),
            "third" -> values(2),
            "fourth" -> values(3)
        )
    }
    def main(args: Array[String]) = {
    assert(f(("python ruby c javascript")).equals(("${first}y, ${second}x, ${third}r, ${fourth}p")));
    }

}
