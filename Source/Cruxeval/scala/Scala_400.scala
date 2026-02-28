import scala.math._
import scala.collection.mutable._
object Problem {
    def f(multi_string : String) : String = {
        val cond_string = multi_string.split(" ").map(_.matches("^[\\p{ASCII}]*$"))
        if (cond_string.contains(true)) {
            multi_string.split(" ").filter(_.matches("^[\\p{ASCII}]*$")).mkString(", ")
        } else {
            ""
        }
    }
    def main(args: Array[String]) = {
    assert(f(("I am hungry! eat food.")).equals(("I, am, hungry!, eat, food.")));
    }

}
