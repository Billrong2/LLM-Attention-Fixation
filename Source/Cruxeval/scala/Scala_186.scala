import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        text.split(" ").map(_.trim).mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f(("pvtso")).equals(("pvtso")));
    }

}
