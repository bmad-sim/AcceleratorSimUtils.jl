#---------------------------------------------------------------------------------------------------
# one_cos

"""
    one_cos(x)

Function to calculate `1 - cos(x)` to machine precision.
This is usful if angle can be near zero where the direct evaluation of `1 - cos(x)` is inaccurate.
""" one_cos

one_cos(x) = 2.0 * sin(x/2.0)^2

#---------------------------------------------------------------------------------------------------
# modulo2

"""
     modulo2(x, amp)

 Function to return
```
     mod2 = x + 2 * n * amp
```
where `n` is an integer chosen such that
```
    -amp <= mod2 < amp
```
""" modulo2

function modulo2(x, amp)
  m2 = mod(x, 2*amp)
  m2 < amp ? (return m2) : (return m2 - 2*amp)
end

#---------------------------------------------------------------------------------------------------
# sincu

"""
  sincu(z, nd::Int = 0)

Returns the unnormalized `sinc(z)` (equal to `sin(z)/z`, no factors of pi here) for `nd = 0`
or the `nd`th derivative for `nd > 0`.

Note: Currently, only `nd = 0` or `1` are implemented
""" sincu(z)

function sincu(z, nd::Int = 0)
  if nd == 0
    return sinc(z/pi)
  elseif nd == 1
    if abs(x) > 1.70
      return (z*cos(z) - sin(z)) / z^2
    else
      c1 = 1.0/3;    c7 = 1.0/45360;     c13 = 1.0/93405312000;      c19 = 1.0/2554547108585472000;
      c3 = 1.0/30;   c9 = 1.0/3991680;   c15 = 1.0/22230464256000;
      c5 = 1.0/840; c11 = 1.0/518918400; c17 = 1.0/6758061133824000;
      z2 = z^2
      return -z * ( c1 - z2 * ( c3 - z2 * ( c5 - z2 * ( c7 - z2 * (c9 - z2
                * (c11 - z2 * (c13 - z2 * (c15 - z2 * (c17 - z2 * c19)))))))))
    end
  else
    error("sincu(z, nd): nd = $nd not yet implemented.")
  end
end

#---------------------------------------------------------------------------------------------------
# coscu

"""
  coscu(x, nd::Int = 0)

Returns, to machine precision, the `nd`th derivative of `(1 - cos(x)) / x^2`. 
If `nd = 0`, returns the function itself. 

Note: Currently, only `nd = 0` or `1` are implemented
""" coscu

function coscu(x, nd::Int = 0)
  if nd == 0
    return 0.5 * sincu(x/2)^2
  elseif nd == 1
    return 0.5 * sincu(x/2) * sincu(x/2, 1)
  else
    error("nd = $nd not yet implemented.")
  end
end
