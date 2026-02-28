import scala.math._
import scala.collection.mutable._
object Problem {
    def f(st : String) : String = {
        val lowerSt = st.toLowerCase()
        val lastHIndex = lowerSt.lastIndexOf('h')
        val lastI1Index = lowerSt.substring(0, lastHIndex).lastIndexOf('i')
        val lastI2Index = lowerSt.lastIndexOf('i')
        if (lastI1Index >= lastI2Index) "Hey" else "Hi"
    }
    def main(args: Array[String]) = {
    assert(f(("Hi there")).equals(("Hey")));
    }

}
