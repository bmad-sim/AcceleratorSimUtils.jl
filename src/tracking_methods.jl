
# ========== Symplectic ===========================
abstract type AbstractSymplectic end

for name in (:DriftKick, :MatrixKick, :BendKick, :SolenoidKick)
@eval begin
  Base.@kwdef struct $name <: AbstractSymplectic
    order::Int = 4
    use_optimized_schemes::Bool = true
    function $name(order, use_optimized_schemes) 
      if !(order in (2, 4, 6, 8, 10))
        error("$($name) only supports orders 2, 4, 6, 8, and 10")
      end
      return new(order, use_optimized_schemes)
    end
  end
end
end

Base.@kwdef struct Implicit <: AbstractSymplectic
  order::Int = 4
  use_optimized_schemes::Bool = true
  use_newton::Bool = false
  function Implicit(order, use_optimized_schemes, use_newton) 
    if !(order in (2, 4, 6, 8, 10))
      error("Implicit only supports orders 2, 4, 6, 8, and 10")
    end
    return new(order, use_optimized_schemes, use_newton)
  end
end


# ========== Exact ===========================
# For patches, maps, markers
struct Exact end

# ========== SaganCavity =====================
Base.@kwdef struct SaganCavity
  n_cells::Int      = -1    # Negative => Use approx half wavelength between cells, Zero => single kick.
  L_active::Float64 = -1.0  # Negative => Use L as the active length.
end

# ========== Explicit RK4 Tracking ==========
struct RK4 end