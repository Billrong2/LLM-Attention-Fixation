import scala.math._
import scala.collection.mutable._

object Problem {
    def f(text : String) : String = {
        val lastIndex = text.lastIndexOf('o')
        val div = if (lastIndex == -1) "-" else text.substring(0, lastIndex)
        val div2 = if (lastIndex == -1) "-" else text.substring(lastIndex + 1)
        if (lastIndex == -1) "-" + text else text.charAt(lastIndex) + div + text.charAt(lastIndex) + div2
    }
    def main(args: Array[String]) = {
    assert(f(("kkxkxxfck")).equals(("-kkxkxxfck")));
    }

}
