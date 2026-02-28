function f(file::String)::Int64 
    return findfirst(isequal('\n'), file) - 1
end
using Test

@testset begin

candidate = f;
	@test(candidate("n wez szize lnson tilebi it 504n.
") == 33)
end
