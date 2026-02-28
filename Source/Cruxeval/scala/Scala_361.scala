import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        text.split(":")(0).count(_ == '#')
    }
    def main(args: Array[String]) = {
    assert(f(("#! : #!")) == (1l));
    }

}
