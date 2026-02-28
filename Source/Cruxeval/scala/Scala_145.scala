import scala.collection.mutable._
import scala.math._
object Problem {
    def f(price: Float, product: String): Float = {
        var updatedPrice = price
        val inventory = ArrayBuffer("olives", "key", "orange")
        
        if (!inventory.contains(product)) {
            return updatedPrice
        } else {
            updatedPrice *= 0.85f
            inventory -= product
        }
        
        updatedPrice
    }
    def main(args: Array[String]) = {
    assert(f((8.5f), ("grapes")) == (8.5f));
    }

}
