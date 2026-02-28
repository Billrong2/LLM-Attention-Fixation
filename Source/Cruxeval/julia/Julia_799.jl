function f(st::String)::String 
    if st[1] == '~'
        e = rpad(st, 10, 's')
        return f(e)
    else
        return lpad(st, 10, 'n')
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("eqe-;ew22") == "neqe-;ew22")
end
