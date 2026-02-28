import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : String, split_on : String) : Boolean = {
        val t = a.split(" ")
        val a_list = t.flatMap(_.toList)
        a_list.contains(split_on)
    }
    def main(args: Array[String]) = {
    assert(f(("booty boot-boot bootclass"), ("k")) == (false));
    }

}
