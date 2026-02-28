function f(num::Int64, name::String)::String 
    f_str = "quiz leader = $name, count = $num"
    return f_str
end
using Test

@testset begin

candidate = f;
	@test(candidate(23, "Cornareti") == "quiz leader = Cornareti, count = 23")
end
