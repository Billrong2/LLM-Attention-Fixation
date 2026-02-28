function f(text::String)::String 
    text = split(text, ',')
    text = filter!(x -> x != "", text) # remove empty strings
    deleteat!(text, 1)
    idx = findfirst(isequal("T"), text)
    insert!(text, 1, splice!(text, idx))
    return join(["T", text...], ",")
end
using Test

@testset begin

candidate = f;
	@test(candidate("Dmreh,Sspp,T,G ,.tB,Vxk,Cct") == "T,T,Sspp,G ,.tB,Vxk,Cct")
end
