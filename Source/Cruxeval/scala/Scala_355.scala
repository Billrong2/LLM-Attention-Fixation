import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, prefix : String) : String = {
        text.substring(prefix.length)
    }
    def main(args: Array[String]) = {
    assert(f(("123x John z"), ("z")).equals(("23x John z")));
    }

}
