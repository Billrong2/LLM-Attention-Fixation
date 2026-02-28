function f(a::Dict{Int64, String})::String 
    s = reverse(collect(a))
    return join(["($(i[1]), '$(i[2])')" for i in s], " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(15 => "Qltuf", 12 => "Rwrepny")) == "(12, 'Rwrepny') (15, 'Qltuf')")
end
