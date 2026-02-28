function f(key::String, value::String)::Tuple{String, String}
    dict_ = Dict(key => value)
    return (key, dict_[key])
end

using Test

@testset begin

candidate = f;
	@test(candidate("read", "Is") == ("read", "Is"))
end
