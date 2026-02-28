import scala.math._
import scala.collection.mutable._
object Problem {
    def f(test : String, sep : String, maxsplit : Long) : List[String] = {
        try {
            test.split(sep, maxsplit.toInt).toList
        } catch {
            case _ => test.split(" ").toList
        }
    }
    def main(args: Array[String]) = {
    assert(f(("ab cd"), ("x"), (2l)).equals((List[String]("ab cd"))));
    }

}
