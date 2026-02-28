function f(text::String)::Bool 
    return isspace.(collect(text)) |> all
end
using Test

@testset begin

candidate = f;
	@test(candidate(" 	  　") == true)
end
