import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, space : Long) : String = {
        if (space < 0) {
            return text
        }
        text.padTo((text.length + space).toInt, ' ')
    }
    def main(args: Array[String]) = {
    assert(f(("sowpf"), (-7l)).equals(("sowpf")));
    }

}
