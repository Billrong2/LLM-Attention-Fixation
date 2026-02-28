import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, position : Long, value : String) : String = {
        val length = text.length
        var index = (position % length).toInt
        if (position < 0) {
            index = length / 2
        }
        val new_text = text.split("").toBuffer
        new_text.insert(index, value)
        new_text.remove(length-1)
        new_text.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("sduyai"), (1l), ("y")).equals(("syduyi")));
    }

}
