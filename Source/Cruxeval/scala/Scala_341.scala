import scala.math._
import scala.collection.mutable._
object Problem {
    def f(cart : Map[Long,Long]) : Map[Long,Long] = {
        var newCart = cart
        while (newCart.size > 5) {
            newCart = newCart - newCart.keysIterator.next()
        }
        newCart
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long]())).equals((Map[Long,Long]())));
    }

}
