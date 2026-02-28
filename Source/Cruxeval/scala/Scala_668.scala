import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        text.last + text.init
    }
    def main(args: Array[String]) = {
    assert(f(("hellomyfriendear")).equals(("rhellomyfriendea")));
    }

}
