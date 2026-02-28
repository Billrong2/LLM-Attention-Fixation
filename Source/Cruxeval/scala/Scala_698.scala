import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        text.filter(_ != ')')
    }
    def main(args: Array[String]) = {
    assert(f(("(((((((((((d))))))))).))))(((((")).equals(("(((((((((((d.(((((")));
    }

}
