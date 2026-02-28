import scala.math._
import scala.collection.mutable._
object Problem {
    def f(messages : List[List[String]]) : String = {
        val phone_code = "+353"
        val result = messages.map{message =>
            (message ++ phone_code.toList).mkString(";")
        }
        result.mkString(". ")
    }
    def main(args: Array[String]) = {
    assert(f((List[List[String]](List[String]("Marie", "Nelson", "Oscar")))).equals(("Marie;Nelson;Oscar;+;3;5;3")));
    }

}
