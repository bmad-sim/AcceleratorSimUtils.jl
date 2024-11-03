using SimUtils
using Test

@testset verbose = true "SimUtils.jl" begin

@testset "math_test" begin
  include("math_test.jl")
end

end
