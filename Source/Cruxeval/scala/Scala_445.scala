import scala.math._
import scala.collection.mutable._
object Problem {
    def f(names : String) : String = {
        val parts = names.split(',')
        for (i <- parts.indices) {
            parts(i) = parts(i).replace(" and", "+").split(' ').map(_.capitalize).mkString(" ")
            parts(i) = parts(i).replace("+", " and")
        }
        parts.mkString(", ")
    }
    def main(args: Array[String]) = {
    assert(f(("carrot, banana, and strawberry")).equals(("Carrot,  Banana,  and Strawberry")));
    }

}
