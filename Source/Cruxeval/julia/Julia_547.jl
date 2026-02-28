function f(letters::String)::String 
    letters_only = strip(letters, [' ', '.', ',', '!', '?', '*'])
    spl = split(letters_only, " ")
    return join(spl, "....")
end

using Test

@testset begin

candidate = f;
	@test(candidate("h,e,l,l,o,wo,r,ld,") == "h,e,l,l,o,wo,r,ld")
end
