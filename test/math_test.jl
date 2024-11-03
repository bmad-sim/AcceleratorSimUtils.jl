using SimUtils, Test

@testset "math_test" begin
  @test cos_one(1e-4) ≈ -4.999999995833334e-9 rtol = 1e-15
  @test cos_one(1) ≈ -0.4596976941318603 rtol = 1e-15
  @test modulo2(2, 2) == -2
  @test modulo2(8, 3) == 2
  @test modulo2(9.0, 3.0) ≈ -3.0 rtol = 1e-15
end