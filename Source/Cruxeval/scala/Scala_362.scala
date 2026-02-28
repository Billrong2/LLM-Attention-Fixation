import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        for(i <- 0 until text.length - 1) {
            if (text.substring(i).forall(_.isLower)) {
                return text.substring(i + 1)
            }
        }
        ""
    }
    def main(args: Array[String]) = {
    assert(f(("wrazugizoernmgzu")).equals(("razugizoernmgzu")));
    }

}
