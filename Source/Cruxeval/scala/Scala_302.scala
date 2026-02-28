import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String) : String = {
        string.replace("needles", "haystacks")
    }
    def main(args: Array[String]) = {
    assert(f(("wdeejjjzsjsjjsxjjneddaddddddefsfd")).equals(("wdeejjjzsjsjjsxjjneddaddddddefsfd")));
    }

}
