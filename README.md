# Sex-Specific-Exercise-Model
Source code for the model presented in Abo, Casella, and Layton (2023) "Sexual Dimorphism in Substrate Metabolism during Exercise"

All female model files can be found in the folder 'female'
All male model files can be found in the folder 'male'

# Additional files
% helper_functions include .m functions to select a colormap and generate figures
% figures.m rerpoduces all figures and tables presented in the main article. It relies on four (4) .MAT files: 
% female.mat: simulation output for 60 mins of exercise at 60% VO2max
% male.mat: simulation output for 60 mins of exercise at 60% VO2max
% male-with-Fmatched-adipose.mat: simulation output for the male model where adiposity (i.e., percentage of body fat is the same as in the female model)
% female-matching-vmax8-sensitivities.mat: simulation output for the female model where control parameters for glycogenolysis (\alpha_L^GIR and \lambda_L^GIR) are the same as in the male model

