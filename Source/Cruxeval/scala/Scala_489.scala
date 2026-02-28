import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, value : String) : String = {
        text.stripPrefix(value.toLowerCase)
    }
    def main(args: Array[String]) = {
    assert(f(("coscifysu"), ("cos")).equals(("cifysu")));
    }

}
