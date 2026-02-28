function f(text::String)::Dict{String, Int64}
    freq = Dict{String, Int64}()
    for c in lowercase(text)
        if haskey(freq, string(c))
            freq[string(c)] += 1
        else
            freq[string(c)] = 1
        end
    end
    return freq
end

using Test

@testset begin

candidate = f;
	@test(candidate("HI") == Dict("h" => 1, "i" => 1))
end
