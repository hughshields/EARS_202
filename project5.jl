## --- 1
using FFTW, Plots, StatGeochem

data = importdataset("Data/BarHarborWL2013.csv", ',', importas=:Tuple)

# Signal: water Level
wl = data.Water_Level
# Number of sample points
N = length(data.Hour_Count)
# Sample period
Ts = 1 #24/N
# Start and end time
t0 = 0
tmax = t0 + N * Ts
# Time coordinate
t = t0:Ts:tmax

# Fast Fourier Transform
ft = fft(wl)
F = fftshift(ft)
freqs = fftshift(fftfreq(N, 1.0/Ts))
# Plot results
time_domain = plot(t[1:end-1]/24, wl, title="Signal", framestyle=:box)
display(time_domain)
freq_domain = plot(freqs, abs.(F), title="Spectrum", yscale=:log10, framestyle=:box, xlim=(0, 0.5), label="Data")
vline!([1/24], linestyle=:dash, color=:red, label="1 per Day")
vline!([1/12], linestyle=:dash, color=:red, label="1 per 12 Hours")
display(freq_domain)

## --- 2
# Keeling Curve data from http://doi.org/10.6075/J08W3BHW at https://scrippsco2.ucsd.edu/data/atmospheric_co2/primary_mlo_co2_record.html
data = importdataset("Data/monthly_in_situ_co2_mlo.csv", ',', importas=:Tuple)
co2 = data.CO2
N = length(data.CO2)
# Sample period
Ts = 1
# Start and end time
t0 = 0
tmax = t0 + N * Ts
# Time coordinate
t = t0:Ts:tmax

# Fast Fourier Transform
ft = fft(co2)
F = fftshift(ft)
freqs = fftshift(fftfreq(N, 1.0))
# Plot results
time_domain = plot(t[1:end-1]/12, co2, title="Signal", framestyle=:box)
display(time_domain)
freq_domain = plot(freqs, abs.(F), title="CO2 Spectrum", yscale=:log10, xlim=(0, 0.5), framestyle=:box, label="Data")
vline!([1/6], linestyle=:dash, color=:red, label="1 per 6 Months")
vline!([1/12], linestyle=:dash, color=:red, label="1 per Year")
display(freq_domain)