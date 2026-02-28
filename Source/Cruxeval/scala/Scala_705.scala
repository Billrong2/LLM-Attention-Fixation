import scala.math._
import scala.collection.mutable._
object Problem {
    def f(cities : List[String], name : String) : List[String] = {
        if (name.isEmpty){
            return cities
        }
        if (name.nonEmpty && name != "cities"){
            return List()
        }
        return cities.map(city => name + city)
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("Sydney", "Hong Kong", "Melbourne", "Sao Paolo", "Istanbul", "Boston")), ("Somewhere ")).equals((List[String]())));
    }

}
