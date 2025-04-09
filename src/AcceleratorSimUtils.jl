module AcceleratorSimUtils

using FFTW, Random
using AtomicAndPhysicalConstants.CODATA2018

@APCdef

export gen_pinknoise
export one_cos, sqrt_one, modulo2, sincu, coscu
export calc_E_tot, calc_E_kinetic, calc_pc, calc_β, calc_1β, calc_γ, calc_changed_energy

include("math.jl")
include("pinknoise.jl")
include("particle_energy_conversions.jl")

end
