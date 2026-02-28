function f(ans::String)::Union{Int64, String} 
    try
        num = parse(Int, ans)
        total = num * 4 - 50
        total -= count(c -> c ∉ "02468", ans) * 100
        return total
    catch
        return "NAN"
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("0") == -50)
end
