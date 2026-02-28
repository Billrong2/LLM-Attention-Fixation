import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        if(text == "42.42") {
            return true
        }
        for(i <- 3 until text.length - 3) {
            if(text(i) == '.' && text.slice(i - 3, text.length).forall(_.isDigit) && text.slice(0, i).forall(_.isDigit)) {
                return true
            }
        }
        false
    }
    def main(args: Array[String]) = {
    assert(f(("123E-10")) == (false));
    }

}
