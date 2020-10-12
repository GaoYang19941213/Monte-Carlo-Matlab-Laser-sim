# Monte-Carlo-Matlab-Laser-sim
Monte Carlo simulation of laser absorption

This is a Matlab execution similar to the C++ software put out by  Steven Jacques, Ting Li, and Scott Prahl found here https://omlc.org/software/mc/mcxyz/index.html. I wrote this to understand the physics behind light simulations and to further improve upon it by allowing for K wave simulation in order to simulate photoacoustic imaging of tissue. I am using a homogenous tissue generator of my own making as well as the heterogenous tissue generator provided by Steven Jacques in his MATLab scripts. For both, I am using a tissue library provided by Steven Jacques that provides the optical properties necessary to perform this analysis. 

You can watch how the software works on the higher level here. 

https://youtu.be/Hf7QJufXPo0

This video was my final presentation for a class, constrained to 5 minutes. There are points that I brush over that I will explain here. I believe in the video, I would say "I don't have time to explain, but please ask me at the end of the rpesentation."

1. Monte Carlo simulation
- We are simulating the random path of a forward scattering photon using a tissue library provided by omlc
- We simulate ~1,000,000 photons and their paths, each time they interact with an element they deposit some energy, make a step towards another element (sometimes skipping over some elements) and adjust its trajectory based on the forward scattering coefficient g
- Divide the deposited energy of the volumetric matrix by the total eneergy fired, and you get a Photon Absorption Probability matrix. The equation for laser absorption is 
Total Energy * PAP = Fluence matrix. You can from there calculate thermal damage or in our future case, calculate vibrational energy created (K-Wave simulation)

2. Validation
- We compared to existing validated research software provided by OMLC. 
- The OMLC software appeared to do a couple things different, such as preventing photons from leaving the boundaries of the tissue matrix, which created differences in visualized results
- The OMLC software also computes PAP, but then outputs the Fluence matrix with an unknown total energy measurement
- If we understand that the PAP is a probability volumetric distribution, that means that the sum of all the elements energy levels = 1
- To convert the output of OMLC to a PAP matrix, and understanding that the OMLC software prevents photons from leaving until all of the energy is deposited, I took the sum of the volumetric matrix energy levels and divided the OMLC Fluence matrix by this sum, essentially leading to this equation: Fluence Matrix/Total Energy = PAP
- I then did a subtraction validation using the my PAP matrix and OMLCs calculated PAP or "normalized Fluence matrix" as I called it in the video
- OMLCs software calculates the amount of photons to generate using a variety of variables, but mine consistently used 1,000,000. I am unsure if this made a significant difference
- There seemed to be some chaotic behavior inside the blood vessel, I understand the OMLC ignores total internal reflection so that may be the source of some of that 

-Karim
