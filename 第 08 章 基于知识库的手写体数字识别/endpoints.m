function g = endpoints(f)

persistent lut
if isempty(lut)
    lut = makelut(@endpoint_fcn, 3);
end

g = applylut(f,lut);

function is_end_point = endpoint_fcn(nhood)
is_end_point = nhood(2,2) & (sum(nhood(:)) == 2);
