function f(row::String)::Tuple{Int64, Int64}
    return (count(i -> i=='1', row), count(i -> i=='0', row))
end

using Test

@testset begin

candidate = f;
	@test(candidate("100010010") == (3, 6))
end
