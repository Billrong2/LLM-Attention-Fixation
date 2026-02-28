function f(text::String, char1::String, char2::String)::String 
    t1a = [char1[i] for i in 1:length(char1)]
    t2a = [char2[i] for i in 1:length(char2)]
    t1 = Dict(zip(t1a, t2a))
    
    translated_text = ""
    for c in text
        if haskey(t1, c)
            translated_text *= t1[c]
        else
            translated_text *= c
        end
    end
    
    return translated_text
end
using Test

@testset begin

candidate = f;
	@test(candidate("ewriyat emf rwto segya", "tey", "dgo") == "gwrioad gmf rwdo sggoa")
end
