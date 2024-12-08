module SimUtils

using FFTW, Random, GTPSA
using AtomicAndPhysicalConstants

@APCdef

export gen_pinknoise
export cos_one, modulo2
export calc_E_tot, calc_E_kinetic, calc_pc, calc_β, calc_β1, calc_γ, calc_changed_energy

include("math.jl")
include("pinknoise.jl")
include("particle_properties_conversion.jl")

end
