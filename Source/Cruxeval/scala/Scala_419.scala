import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, value : String) : String = {
        if (!text.contains(value)) {
            return ""
        }
        text.split(value)(0)
    }
    def main(args: Array[String]) = {
    assert(f(("mmfbifen"), ("i")).equals(("mmfb")));
    }

}
