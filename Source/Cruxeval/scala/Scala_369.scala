import scala.collection.mutable._
import scala.math._
object Problem {
    def f(input: String): String = {
        if (input.forall(_.isDigit)) {
            "int"
        } else if (input.replaceFirst("\\.", "").forall(_.isDigit)) {
            "float"
        } else if (input.count(_ == ' ') == input.length - 1) {
            "str"
        } else if (input.length == 1) {
            "char"
        } else {
            "tuple"
        }
    }
    def main(args: Array[String]) = {
    assert(f((" 99 777")).equals(("tuple")));
    }

}
