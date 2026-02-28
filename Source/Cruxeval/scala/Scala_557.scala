import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        s.lastIndexOf("ar") match {
            case -1 => s
            case n => s.substring(0, n) + " " + "ar" + " " + s.substring(n+2)
        }
    }
    def main(args: Array[String]) = {
    assert(f(("xxxarmmarxx")).equals(("xxxarmm ar xx")));
    }

}
