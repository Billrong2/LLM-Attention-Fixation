function f(string::String)::Int64
    try
        return findlast(==('e'), string) - 1
    catch e
        if isa(e, ArgumentError)
            return -1
        else
            rethrow()
        end
    end
end

using Test

@testset begin

candidate = f;
	@test(candidate("eeuseeeoehasa") == 8)
end
