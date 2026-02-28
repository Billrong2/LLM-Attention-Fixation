function f(string::String, code::String)::String
    try
        t = code(string, code)
        if t.endswith(b'\n')
            t = t[1:end-1]
        end
        t = String(t)
        return t
    catch
        return string
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("towaru", "UTF-8") == "towaru")
end
