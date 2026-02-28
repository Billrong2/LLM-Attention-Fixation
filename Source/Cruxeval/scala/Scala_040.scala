import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        text.padTo(text.length + 1, '#').mkString
    }
    def main(args: Array[String]) = {
    assert(f(("the cow goes moo")).equals(("the cow goes moo#")));
    }

}
