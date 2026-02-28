import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text1 : String, text2 : String) : Long = {
        var nums = ListBuffer[Int]()
        for (i <- 0 until text2.length) {
            nums += text1.count(_ == text2(i))
        }
        nums.sum
    }
    def main(args: Array[String]) = {
    assert(f(("jivespdcxc"), ("sx")) == (2l));
    }

}
