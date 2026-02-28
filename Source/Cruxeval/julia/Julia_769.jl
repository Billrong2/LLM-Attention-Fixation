function f(text::String)::String 
    text_list = [uppercase(text[i]) == text[i] ? lowercase(text[i]) : uppercase(text[i]) for i in 1:length(text)]
    return join(text_list, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("akA?riu") == "AKa?RIU")
end
