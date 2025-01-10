using AcceleratorSimUtils, Test

@testset "math_test" begin
  @test one_cos(1e-4) ≈ 4.999999995833334e-9 rtol = 1e-15
  @test one_cos(1) ≈ 0.4596976941318603 rtol = 1e-15
  @test sincu(1.0) ≈ 0.8414709848078965 rtol = 1e-15
  @test abs(0.5e6 * (sincu(1.0+1e-6) - sincu(1.0-1e-6)) - sincu(1.0, 1)) < 1.0e-12
  @test coscu(1.0) ≈ 0.4596976941318603 rtol = 1e-15
  @test abs(0.5e6 * (coscu(1.0+1e-6) - coscu(1.0-1e-6)) - coscu(1.0, 1)) < 1.0e-10
  @test modulo2(2, 2) == -2
  @test modulo2(8, 3) == 2
  @test modulo2(9.0, 3.0) ≈ -3.0 rtol = 1e-15
end