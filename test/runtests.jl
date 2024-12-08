using SimUtils
using Test

@testset verbose = true "SimUtils.jl" begin

  @testset "math_test" begin
    include("math_test.jl")
  end

  @testset "particle_test" begin
    include("particle_test.jl")
  end

  @testset "pink_test" begin
    include("pink_test.jl")
  end

end

print("")  # To surpress trailing garbage output