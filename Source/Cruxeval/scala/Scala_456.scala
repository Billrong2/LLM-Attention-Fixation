import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, tab : Long) : String = {
        s.replaceAll("\t", " " * tab.toInt)
    }
    def main(args: Array[String]) = {
    assert(f(("Join us in Hungary"), (4l)).equals(("Join us in Hungary")));
    }

}
