# Signals & Systems — Laboratory Practicals and Course Project

A collection of MATLAB implementations for practical experiments and final coursework in **Signals & Systems**, covering signal representation, system properties, transformation techniques, and orthogonal signal space analysis.

- **Student ID:** `12502060601042`
- **Platform:** MATLAB / GNU Octave

---

## 📋 Table of Practicals

| Practical | Script | Topic & Description |
| :---: | :--- | :--- |
| **01** | [`practical_01.m`](practical_01.m) | **Introduction to MATLAB Environment**<br>Basic arithmetic operations, continuous-time sine wave and discrete-time cosine wave generation. |
| **02** | [`practical_02.m`](practical_02.m) | **Elementary Signal Generation & Transformations**<br>Impulse, Unit Step, Ramp, and Signum signals; time-shifting transformations `(t - 2)` and `(t + 2)`. |
| **03** | [`practical_03.m`](practical_03.m) | **Continuous-Time Domain Waveforms**<br>Generation and plotting of Sinc function, Triangular wave, Sawtooth wave, and Exponential signals. |
| **04** | [`practical_04.m`](practical_04.m) | **System Properties Verification**<br>Testing Linearity (superposition) and Time-Invariance (delay property) on discrete-time systems. |
| **05** | [`practical_05.m`](practical_05.m) | **Linear Convolution Algorithm**<br>Custom implementation of discrete linear convolution from mathematical definition (without `conv`). |
| **06** | [`practical_06.m`](practical_06.m) | **System Analysis Tools**<br>Analysis of discrete-time LTI systems using `impz` (impulse response), `filter`, and `freqz` (frequency response). |
| **07** | [`practical_07.m`](practical_07.m) | **Fourier Series Synthesis**<br>Harmonic synthesis and reconstruction of square wave signals using trigonometric Fourier series. |
| **08** | [`practical_08.m`](practical_08.m) | **Continuous Fourier Transform (CFT)**<br>Numerical Fourier transform calculation with magnitude and phase spectral analysis. |
| **09** | [`practical_09.m`](practical_09.m) | **Z-Transform and Pole-Zero Analysis**<br>Symbolic Z-transform, inverse Z-transform, and pole-zero plot mapping (`pzmap`). |

---

## 🎯 Course Project: Orthogonal Signal Space & Fourier Series

- **File:** [`project_final.m`](project_final.m)
- **Topic:** Orthogonal Signal Space and Fourier Series Approximation
- **Key Modules:**
  1. **Square Wave Generation**: Numerical representation over fundamental period $T_0 = 2\pi$.
  2. **Orthogonality Verification**: Numerical integration demonstrating inner products $\langle \cos(n\omega_0 t), \cos(m\omega_0 t) \rangle = 0$ for $n \ne m$ and harmonic orthogonality.
  3. **Fourier Series Coefficients**: Numerical calculation of $a_0$, $a_n$, and $b_n$ coefficients.
  4. **Harmonic Reconstruction**: Progressive waveform synthesis comparing approximations across harmonics with error calculation.

---

## 🚀 How to Run

1. Open MATLAB.
2. Set the working directory to this folder:
   ```matlab
   cd('C:/signals and system')
   ```
3. Run any experiment or the project directly:
   ```matlab
   run('practical_01.m')
   run('project_final.m')
   ```
