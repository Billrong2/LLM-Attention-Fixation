import scala.math._
import scala.collection.mutable._
object Problem {
    def f(countries : Map[String,String]) : Map[String,List[String]] = {
        var language_country = Map[String, List[String]]()
        for ((country, language) <- countries) {
            if (!language_country.contains(language)) {
                language_country += (language -> List[String]())
            }
            language_country += (language -> (language_country(language) :+ country))
        }
        language_country
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,String]())).equals((Map[String,List[String]]())));
    }

}
