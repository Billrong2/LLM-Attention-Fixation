function f(s::String)::Dict{String, Int64}
    count = Dict{String, Int64}()
    for i in s
        if islowercase(i)
            if haskey(count, string(i))
                count[string(i)] = count[string(i)] + countlowercase(s, i)
            else
                count[string(i)] = countlowercase(s, i)
            end
        else
            if haskey(count, lowercase(string(i)))
                count[lowercase(string(i))] = count[lowercase(string(i))] + countuppercase(s, uppercase(i))
            else
                count[lowercase(string(i))] = countuppercase(s, uppercase(i))
            end
        end
    end
    return count
end

function countlowercase(s::String, i::Char)::Int64
    count = 0
    for j in s
        if j == i
            count += 1
        end
    end
    return count
end

function countuppercase(s::String, i::Char)::Int64
    count = 0
    for j in s
        if j == i
            count += 1
        end
    end
    return count
end

using Test

@testset begin

candidate = f;
	@test(candidate("FSA") == Dict("f" => 1, "s" => 1, "a" => 1))
end
