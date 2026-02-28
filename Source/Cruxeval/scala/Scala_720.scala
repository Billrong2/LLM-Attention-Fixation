import scala.math._
import scala.collection.mutable._
object Problem {
    def f(items : List[String], item : String) : Long = {
        var itemsBuffer = items.toBuffer
        while (itemsBuffer.last == item) {
            itemsBuffer.remove(itemsBuffer.size - 1)
        }
        itemsBuffer += item
        itemsBuffer.size
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("bfreratrrbdbzagbretaredtroefcoiqrrneaosf")), ("n")) == (2l));
    }

}
