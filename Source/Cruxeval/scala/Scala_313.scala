import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, l : Long) : String = {
        val newS = s.padTo(l.toInt, '=').reverse
        val index = newS.indexOf('=')
        if (index == -1) newS.reverse else newS.slice(index + 1, newS.length).reverse
    }
    def main(args: Array[String]) = {
    assert(f(("urecord"), (8l)).equals(("urecord")));
    }

}
