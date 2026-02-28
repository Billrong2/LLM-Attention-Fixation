import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        text.forall(_.isValidByte)
    }
    def main(args: Array[String]) = {
    assert(f(("wW의IV]HDJjhgK[dGIUlVO@Ess$coZkBqu[Ct")) == (false));
    }

}
