function f(text::String)::String 
    if text != "" && text == uppercase(text)
        cs = Dict(zip(uppercase('A':'Z'), lowercase('a':'z')))
        return join([get(cs, c, c) for c in text])
    end
    return lowercase(text)[1:3]
end
using Test

@testset begin

candidate = f;
	@test(candidate("mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n") == "mty")
end
