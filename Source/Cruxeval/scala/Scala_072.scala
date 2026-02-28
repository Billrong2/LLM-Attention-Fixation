import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        for (c <- text){
            if (!c.isDigit){
                return false
            }
        }
        text.nonEmpty
    }
    def main(args: Array[String]) = {
    assert(f(("99")) == (true));
    }

}
