function f(fields::Tuple{String, String, String}, update_dict::Dict{String, String})::Dict{String, String} 
    di = Dict{String, String}(x => "" for x in fields)
    di = merge(di, update_dict)
    return di
end
using Test

@testset begin

candidate = f;
	@test(candidate(("ct", "c", "ca"), Dict("ca" => "cx")) == Dict("ct" => "", "c" => "", "ca" => "cx"))
end
