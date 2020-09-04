function [spectra] = paraspec(phi1 ,phi2, delta, w)
spectra = ((1+delta*exp(-1i*w)).*(1+delta*exp(1i*w)))./ ...
            ((1-phi1*exp(-1i*w)-phi2*exp(-2i*w)).*(1-phi1*exp(1i*w)-phi2*exp(2i*w)));
end