import scala.math._
import scala.collection.mutable._
object Problem {
    def f(tokens : String) : String = {
        val tokensArray = tokens.split(" ")
        if (tokensArray.length == 2) {
            val reversedTokens = tokensArray.reverse
            val result = reversedTokens(0).padTo(5, ' ') + " " + reversedTokens(1).padTo(5, ' ')
            return result
        } else {
            val result = tokensArray(0).padTo(5, ' ') + " " + tokensArray(1).padTo(5, ' ')
            return result
        }
    }
    def main(args: Array[String]) = {
    assert(f(("gsd avdropj")).equals(("avdropj gsd  ")));
    }

}
