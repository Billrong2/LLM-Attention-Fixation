import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        (text.length - text.split("bot").length + 1)
    }
    def main(args: Array[String]) = {
    assert(f(("Where is the bot in this world?")) == (30l));
    }

}
