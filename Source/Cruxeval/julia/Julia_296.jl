function f(url::String)::String 
    return replace(url, "http://www." => "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("https://www.www.ekapusta.com/image/url") == "https://www.www.ekapusta.com/image/url")
end
