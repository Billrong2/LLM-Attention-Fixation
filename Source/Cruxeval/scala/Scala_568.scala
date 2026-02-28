import scala.math._
import scala.collection.mutable._
object Problem {
    def f(num : String) : String = {
        var letter = 1
        var numCopy = num
        for (i <- '1' to '9') {
            numCopy = numCopy.replace(i.toString,"")
            if(numCopy.length == 0) return numCopy
            numCopy = numCopy.slice(letter, numCopy.length) + numCopy.slice(0, letter)
            letter += 1
        }
        numCopy
    }
    def main(args: Array[String]) = {
    assert(f(("bwmm7h")).equals(("mhbwm")));
    }

}
