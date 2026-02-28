import scala.collection.mutable._
import scala.math._
object Problem {
    def f(dictionary: Map[String, Long], key: String): String = {
        var updatedDictionary = dictionary - key
        val minKey = updatedDictionary.keys.min
        var newKey = key
        if (minKey == key) {
            newKey = updatedDictionary.keys.head
        }
        newKey
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("Iron Man" -> 4l, "Captain America" -> 3l, "Black Panther" -> 0l, "Thor" -> 1l, "Ant-Man" -> 6l)), ("Iron Man")).equals(("Iron Man")));
    }

}
