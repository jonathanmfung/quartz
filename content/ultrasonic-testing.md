---
title: Ultrasonic Testing
date: 2025-08-29T11:07:33-0700
tags:
  - non-destructive-testing
---

https://www.nde-ed.org/NDETechniques/Ultrasonics/index.xhtml

# Introduction #
- Advantages
  - Senses both surface and subsurface discontinuities
  - Minimal part preparation
- Limitations
    - Coupling medium required
    - Difficulty with rough, irregular, small, thin parts
    - Difficulty with coarse-grain materials
- Straight Beam Testing: transducer (and waves) are normal to test surface
- Transducer: a device that converts electrical energy to acoustical energy, or vice versa
- Thickness Measuring: If material speed of sound is know, calculate time of signal going to backwall and bouncing back
    - A defect will reflect waves sooner and absorb some energy, meaning backwall peak is lower
- Angle Beam Testing
    - Add an angled plastic block between transducer and part
    - non-normal angle of incidence means shear waves are produced
    - Shear/S Wave: particle motion is orthogonal to direction of propagation
    - Compression/Longitudinal/P Wave: particle motion is parallel to direction of propagation
    - Waves are also refracted, Knell's law
        - Speed of shear waves is slower than longitudinal waves, so refraction angle is different
- Immersion Ultrasonic Testing
    - Both transducer and part are immersed in water
        - Can also refer to when sound travels through water jets
    - Additional medium introduces a front wall peak, which is after the initial pulse peak

# Transducers and Other Equipment #
- Piezoelectric Transducers
    - Piezoelectric effect: crystal produces electric field when undergoing strain, and vice versa
    - Active element thickness is proportionate to output frequency
        - thickness is 1/2 the desired wavelength
    - Impedance matching element sits between active element and external face
        - matching layer thickness should be 1/4 of desired wavelength
        - Contact transducers' matching layer has acoustical impedance between active element and steel
            - Contact transducers also have a wear plate
        - Immersion transducers' matching layer has acoustical impedance between active element and water
    -  Backing material behind active element influences damping characteristics
        - Backing material impedance should be similar to active element for effective damping
        - Effective damping means wider bandwidth and higher sensitivity
        - Higher mismatch means increasing material penetration but reduced sensitivity
- Transducer efficiency, bandwidth, and frequency
    - Sensitivity to small defects is proportional to transmission efficiency * receiving efficiency
    - Resolution requires a highly damped transducer
        - Resolution: ability to locate defects near surface
    - Bandwidth: range of frequencies
        - Highly damped transducers will respond to frequencies above and below central frequency
    - Broad frequency range means high resolving power but less penetration
    - Lower frequencies provide more penetration but less sensitivity
        - sensitivity also includes thickness measurement capabilities

## Radiated Fields of Ultrasonic Transducers ##

# Measurement Techniques #

# Calibration Methods and Formulas #

# Some Applications #

# Techniques with Electromagnetic Acoustic Transducers #
