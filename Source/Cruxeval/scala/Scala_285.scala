import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, ch : String) : Long = {
        text.count(_ == ch.head)
    }
    def main(args: Array[String]) = {
    assert(f(("This be Pirate's Speak for 'help'!"), (" ")) == (5l));
    }

}
