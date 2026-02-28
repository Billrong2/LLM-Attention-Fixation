function f(sentence::String)::String 
    if sentence == ""
        return ""
    end
    sentence = replace(sentence, "(" => "")
    sentence = replace(sentence, ")" => "")
    sentence = uppercase(sentence[1])*lowercase(sentence[2:end])
    sentence = replace(sentence, " " => "")
    return sentence
end
using Test

@testset begin

candidate = f;
	@test(candidate("(A (b B))") == "Abb")
end
