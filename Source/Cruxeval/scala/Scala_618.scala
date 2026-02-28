import scala.math._
import scala.collection.mutable._
object Problem {
    def f(matchStr : String, fill : String, n : Long) : String = {
        fill.take(n.toInt) + matchStr
    }
    def main(args: Array[String]) = {
    assert(f(("9"), ("8"), (2l)).equals(("89")));
    }

}
