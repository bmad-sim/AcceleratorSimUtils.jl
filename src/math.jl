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
# un_sinc

"""
  un_sinc(x, nd::Int = 0)

Returns the unnormalized `sinc(x)` (equal to `sin(x)/x`, no factors of pi here) for `nd = 0`
or the `nd`th derivative for `nd > 0`.

Note: Currently, only `nd = 0` or `1` are implemented
""" un_sinc(x)

function un_sinc(x, nd::Int = 0)
  if nd == 0
    return sinc(x/pi)
  elseif nd == 1
    if abs(x) > 1
      return (x*cos(x) - sin(x)) / x^2
    else
      c1 = -1.0/3; c3 = 1.0/30; c5 = -1.0/840; c7 = 1.0/45360; c9 = -1.0/3991680; c11 = 1.0/518918400
      c13 = -1.0/93405312000; c15 = 1.0/22230464256000; c17 = -1.0/6758061133824000
      x2 = x^2
      return x * (c1 + x2 * (c3 + x2 * (c5 + x2 * (c7 + x2 * (c9 + x2 * (c11 + x2 * 
                 (c13 + x2 * (c15 + x2 * c17))))))))
    end
  else
    error("nd = $nd not yet implemented.")
  end
end

#---------------------------------------------------------------------------------------------------
# un_cosc

"""
  un_cosc(x, nd::Int = 0)

Returns, to machine precision, the `nd`th derivative of `(1 - cos(x)) / x^2`. 
If `nd = 0`, returns the function itself. 

Note: Currently, only `nd = 0` or `1` are implemented
""" un_cosc

function un_cosc(x, nd::Int = 0)
  if nd == 0
    return 0.5 * un_sinc(x/2)^2
  elseif nd == 1
    return 0.5 * un_sinc(x/2) * un_sinc(x/2, 1)
  else
    error("nd = $nd not yet implemented.")
  end
end