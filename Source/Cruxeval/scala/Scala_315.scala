import scala.math._
import scala.collection.mutable._
object Problem {
    def f(challenge : String) : String = {
        challenge.toLowerCase.replace('l', ',')
    }
    def main(args: Array[String]) = {
    assert(f(("czywZ")).equals(("czywz")));
    }

}
