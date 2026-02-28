import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, to_place : String) : String = {
        val after_place = text.substring(0, text.indexOf(to_place) + 1)
        val before_place = text.substring(text.indexOf(to_place) + 1)
        return after_place + before_place
    }
    def main(args: Array[String]) = {
    assert(f(("some text"), ("some")).equals(("some text")));
    }

}
