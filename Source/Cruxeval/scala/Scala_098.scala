import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : Int = {
        s.split(" ").count(_.matches("\\p{Lu}\\p{Ll}*"))
    }
    def main(args: Array[String]) = {
    assert(f(("SOME OF THIS Is uknowN!")) == (1l));
    }

}
