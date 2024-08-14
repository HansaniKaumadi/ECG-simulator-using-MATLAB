# ECG-simulator-using-MATLAB
 Basic ECG signal processing using MATLAB, including noise filtering, frequency domain analysis, and a custom notch filter to remove 50 Hz noise.

This project focuses on basic ECG (Electrocardiogram) signal processing using MATLAB. The code demonstrates essential techniques for filtering and analyzing ECG signals, with the goal of reducing noise and enhancing signal clarity.

Features:
Loading and Visualizing ECG Data: The project starts by loading ECG data stored in ASCII format and visualizing the raw signal.

Averaging Filter Implementation: An averaging filter is applied to the ECG signal to remove noise by smoothing the data points.

Noise Addition: Artificial noise, specifically a 50 Hz sinusoidal signal, is added to the filtered ECG signal to simulate interference commonly encountered in real-world ECG recordings.

Frequency Domain Analysis: The Fast Fourier Transform (FFT) is used to convert the time-domain ECG signals (both clean and noisy) into the frequency domain for spectral analysis.

Notch Filter Design: A custom notch filter is implemented to remove the 50 Hz noise from the ECG signal. The recovered signal is then analyzed and compared to the original signal.

Applications:
This project is a foundational step towards more advanced ECG signal processing tasks, including the detection of heart conditions, noise reduction, and data analysis for medical diagnostics.

How to Use:
Clone the repository.
Load the provided ECG data (ecgdata.dat) or replace it with your own ECG data in ASCII format.
Run the MATLAB script to visualize the ECG signal, apply filters, add noise, and perform frequency domain analysis.

Requirements:
MATLAB (version compatible with FFT and basic plotting functions)
ECG data file (ecgdata.dat) in ASCII format

Notes:
This project is educational and serves as a base for more complex signal processing tasks. It can be expanded with additional filters, noise sources, and analysis techniques to suit specific research or medical needs.

