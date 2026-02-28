import scala.math._
import scala.collection.mutable._
object Problem {
    def f(mess : String, char : String) : String = {
        var message = mess
        while (message.indexOf(char, message.lastIndexOf(char) + 1) != -1) {
            val index = message.lastIndexOf(char)
            message = message.substring(0, index + 1) + message.substring(index + 2)
        }
        message
    }
    def main(args: Array[String]) = {
    assert(f(("0aabbaa0b"), ("a")).equals(("0aabbaa0b")));
    }

}
