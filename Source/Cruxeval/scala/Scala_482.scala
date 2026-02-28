import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        text.replace("\\\"", "\"")
    }
    def main(args: Array[String]) = {
    assert(f(("Because it intrigues them")).equals(("Because it intrigues them")));
    }

}
