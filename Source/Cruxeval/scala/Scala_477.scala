import scala.math._
import scala.collection.mutable._

object Problem {
    def f(text : String) : Tuple2[String, String] = {
        val splitText = text.split('|')
        val topic = splitText.init.mkString("|")
        val problem = splitText.last
        val new_problem = if (problem == "r") topic.replace('u', 'p') else problem
        (topic, new_problem)
    }
    def main(args: Array[String]) = {
    assert(f(("|xduaisf")).equals((("", "xduaisf"))));
    }

}
