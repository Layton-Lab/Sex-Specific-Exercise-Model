# Sex-Specific-Exercise-Model
Source code for the model presented in Abo, Casella, and Layton (2023) "Sexual Dimorphism in Substrate Metabolism during Exercise"

All female model files can be found in the folder 'female'

All male model files can be found in the folder 'male'

# Additional files

helper_functions include .m functions to select a colormap and generate figures

figures.m rerpoduces all figures and tables presented in the main article. It relies on four (4) .MAT files, which you will need to produce. 

female.mat: simulation output for 60 mins of exercise at 60% VO2max. Run 'validationFemale.m' then save the output with " save('female.mat') "

male.mat: simulation output for 60 mins of exercise at 60% VO2max. Run 'validationMale.m' then save the output with " save('female.mat') "

male-with-Fmatched-adipose.mat: simulation output for the male model where adiposity (i.e., percentage of body fat is the same as in the female model). Step 1: go to male/exerciseMod.m and let WA=70*0.295. This sets the weight of adipose tissue to 29.5% of total bodyweight; step 2: run 'validationMale.m' then save the output with " save('male-with-Fmatched-adipose.mat')".
  
female-matching-vmax8-sensitivities.mat: simulation output for the female model where control parameters for glycogenolysis (\alpha_L^GIR and \lambda_L^GIR) are the same as in the male model. Step 1: go to female/liver.m and let lambda8=3; alpha8=0.05 (male-matched sensitivity values); step 2: run 'validationFemale.m' then save the output with " save('female-matching-vmax8-sensitivities.mat')".

ONLY ONCE all of these steps are completed can you run 'figures.m'.

