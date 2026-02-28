import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : String) : String = {
        a.split(' ').filter(_.nonEmpty).mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f((" h e l l o   w o r l d! ")).equals(("h e l l o w o r l d!")));
    }

}
