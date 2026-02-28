function f(sentences::String)::String 
    if all(tryparse(Float64, sentence) !== nothing for sentence in split(sentences, '.'))
        return "oscillating"
    else
        return "not oscillating"
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("not numbers") == "not oscillating")
end
