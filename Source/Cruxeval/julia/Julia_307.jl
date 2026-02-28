function f(text::String)::String 
    rtext = collect(text)
    for i in 2:length(rtext)-1
        insert!(rtext, i+1, '|')
    end
    return join(rtext)
end
using Test

@testset begin

candidate = f;
	@test(candidate("pxcznyf") == "px|||||cznyf")
end
