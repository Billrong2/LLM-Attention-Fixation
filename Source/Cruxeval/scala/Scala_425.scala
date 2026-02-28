import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : String) : List[String] = {
        val replaced = a.replace("/", ":")
        val z = replaced.split(":")
        List(z(0), ":", z(1))
    }
    def main(args: Array[String]) = {
    assert(f(("/CL44     ")).equals((List[String]("", ":", "CL44     "))));
    }

}
