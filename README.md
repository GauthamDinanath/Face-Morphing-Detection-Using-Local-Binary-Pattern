# Face Morphing Detection Using Local Binary Pattern
 
## Motivation: 
It is possible to create from two facial images a combined image that is basically the average of the two images both in geometry as well in texture. It turns out that these face morph when compared to either contributing face by automated face recognition software results in a good match. This means that if e.g. a passport were constructed using the morphed face image, both contributers could use the passport to cross an automated border control gate. It goes without saying that this poses a serious security threat.

## Problem statement: 
Investigate and test methods for detection of morphed face photographs.

## Dataset: 
FRGC Dataset
PutDB Dataset
AMSL Face Morph Dataset

## Requirements:
`Matlab 2019b`

## Approach:
![1](https://user-images.githubusercontent.com/64839751/92324440-f8724400-f041-11ea-9f1c-04789f1b3fed.png)

- **Feature Extraction Method used:**
    - Local Binary Pattern
    - Histogram of Oriented Gradients
    - Binarized Statistical Image Features
 
 ![2](https://user-images.githubusercontent.com/64839751/92324285-9d8c1d00-f040-11ea-8317-b3cf6ddb2193.png)
 
 ![3](https://user-images.githubusercontent.com/64839751/92324288-9ebd4a00-f040-11ea-98e2-3518d144b0d5.png)
 
 
 - **Experiments:**
     - Experiment 1: Performance on FRGC dataset
     - Experiment 2: Performance on Noised FRGC dataset
     - Experiment 3: Cross-Dataset performance
     - Experiment 4: Mixed dataset performance
  
  ## Results: 
  In all the experiments, BSIF showed the best overall performance when compared to LBP and HoG but LBP gave the lowest APCER values.
  
  ![4](https://user-images.githubusercontent.com/64839751/92324286-9e24b380-f040-11ea-9c80-3adb8c549e42.png)
  
  

