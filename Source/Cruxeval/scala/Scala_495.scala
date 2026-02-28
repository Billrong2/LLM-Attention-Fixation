import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : (String, String) = {
        if(s.takeRight(5).forall(_.toInt < 128)) (s.takeRight(5), s.take(3))
        else if(s.take(5).forall(_.toInt < 128)) (s.take(5), s.takeRight(5).drop(3))
        else (s, "")
    }
    def main(args: Array[String]) = {
    assert(f(("a1234år")).equals((("a1234", "år"))));
    }

}
