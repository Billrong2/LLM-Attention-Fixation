import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, character : String) : String = {
        val subject = text.takeRight(text.lastIndexOf(character) + 1)
        subject*(text.count(_ == character))
    }
    def main(args: Array[String]) = {
    assert(f(("h ,lpvvkohh,u"), ("i")).equals(("")));
    }

}
