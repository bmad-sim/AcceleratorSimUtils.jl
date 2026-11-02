
# ========== Symplectic ===========================
abstract type AbstractSymplectic end

for name in (:DriftKick, :MatrixKick, :BendKick, :SolenoidKick)
@eval begin
  Base.@kwdef struct $name <: AbstractSymplectic
    order::Int = 4
    opt_scheme::Bool = true
    function $name(order, opt_scheme) 
      if !(order in (2, 4, 6, 8, 10))
        error("$($name) only supports orders 2, 4, 6, 8, and 10")
      end
      return new(order, opt_scheme)
    end
  end
end
end

Base.@kwdef struct Implicit <: AbstractSymplectic
  order::Int = 4
  opt_scheme::Bool = true
  use_newton::Bool = false
  function Implicit(order, opt_scheme, use_newton) 
    if !(order in (2, 4, 6, 8, 10))
      error("Implicit only supports orders 2, 4, 6, 8, and 10")
    end
    return new(order, opt_scheme, use_newton)
  end
end


# ========== Exact ===========================
# For patches, maps, markers, thin elements
struct Exact end

# ========== SaganCavity =====================
Base.@kwdef struct SaganCavity
  n_cells::Int      = -1    # Negative => Use approx half wavelength between cells, Zero => single kick.
  L_active::Float64 = -1.0  # Negative => Use L as the active length.
end

# ========== Explicit RK4 Tracking ==========
struct RK4 end