function f(s::String, tab::Int64)::String 
    return replace(s, "\t" => repeat(" ", tab))
end
using Test

@testset begin

candidate = f;
	@test(candidate("Join us in Hungary", 4) == "Join us in Hungary")
end
