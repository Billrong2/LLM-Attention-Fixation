import scala.math._
import scala.collection.mutable._
object Problem {
    def f(title : String) : String = {
        title.toLowerCase
    }
    def main(args: Array[String]) = {
    assert(f(("   Rock   Paper   SCISSORS  ")).equals(("   rock   paper   scissors  ")));
    }

}
