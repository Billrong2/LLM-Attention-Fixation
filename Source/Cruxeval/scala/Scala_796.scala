import scala.math._
import scala.collection.mutable._
object Problem {
    def f(str : String, toget : String) : String = {
        if (str.startsWith(toget)) {
            str.substring(toget.length)
        } else {
            str
        }
    }
    def main(args: Array[String]) = {
    assert(f(("fnuiyh"), ("ni")).equals(("fnuiyh")));
    }

}
