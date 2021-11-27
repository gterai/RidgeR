# How to use
You can use our programs using the Docker framework. Download "workdir.tar.gz" and "Dockerfile" in a directory you like. Then type the following command in the directory.

```
docker build -t ridger:0 -f Dockerfile .
```

Now, you are able to run our programs.

## Extracting secondary structural features from single RNA sequences.
 The optSingle.pl is a program for extracting secondary structural features from single RNA sequences and their corresponding activity data.
 You can run it by the following two simple steps.

### 1) Preparing a data directory
You have to prepare a data directory in which “seq.fa” and “act.txt” files are included.
The seq.fa file contains RNA sequences in the FASTA format, and act.txt file contains their activity values in a tab delimited format (Please see the act.txt file in the example/single directory in the example.tar.gz file).

### 2) Running the program
Type the following command.

```
docker run -it --rm  -v [data directory]:/wdir/data ridger:0 ./optSingle.pl [Alpha] [# CPU]
```

Please replace [data directory] to a path to the data directory. [Alpha] is the regularization parameter used in Ridge regression.
For the data in the example/single directory, use alpha=1000. For other datasets, ou need to adjust the value of [Alpha] for each dataset.
[# CPU] is the number of CPUs to be used. You should set it according to the available CPUs in your system.

### 3) Output files
Output files are found in the [data directory]/out directory, unless you do not specify the name of the output directory.
The w_fin.txt file in the directory contains the optimized regression parameters (coefficients). The parameter values tell us which
structural features increase/reduce bioactivity.
For example, a value of wL_i in the w_fin.txt represents the effect of the i-th base being the left side of a base pair.
Please see, the main text for the explanation of the regression parameters.
The nnfv.txt file contains feature vectors and normalized bioactivity values used to optimize the regression parameters. You can extract position-specific features from this file or use it for the analysis with other machine learning algorithms.


## Extracting secondary structural features from pairs of two short RNA sequences
The optPair.pl is a program for extracting secondary structural features from two interacting RNA sequences and their corresponding activity data.
You can run it by almost the same two steps as the optSingle.pl program.
 
### 1) Preparing a data directory
You have to prepare a data directory in which “seqX.fa”, “seqY.fa” and “act.txt” files are included.
The seqX.fa file contains an RNA sequence, the seqY.fa file contains RNA sequences in the FASTA format, and act.txt file contains their activity values in a tab delimited format (Please see the act.txt file in the example/pair directory in the example.tar.gz file). Currently, the seqX file must not contain multiple RNA sequences.

### 2) Running the program
Type the following command.
```
docker run -it --rm  -v [data directory]:/wdir/data ridger:0 ./optPair.pl [Alpha] [# CPU]
```

[Alpha] is the regularization parameter used in Ridge regression. For the data in the example/pair directory, use alpha=1000. [# CPU] is the number of CPUs to be used.

### 3) Output files
Output files are found in the [data directory]/out directory, unless you do not specify the name of the output directory.
The w_fin.txt file in the directory contains the optimized regression parameters (coefficients). The parameter values tell us which structural features increase/reduce bioactivity.
For example a value of wI_x_i in the w_fin.txt represents the effect of the i-th base of the RNA sequence in seqX.fa belongs to an internal loop.
Please see, the main text for the explanation of parameters. The nnfv.txt file contains feature vectors and normalized bioactivity values used to optimize the regression parameters. You can extract position-specific features from this file or use it for the analysis with other machine learning algorithms.

## Options
```
-O string  : set the name of the output directory (default:out)  
```

# Tutorials
## How to run out software to the datasets used in our paper (dataset1-5)
Unzip the tar.gz file of each data set, and you will get seq.fa, act.txt, and other files. Copy those files to the data directory of your choice name. By running the program as per the instructions above, you can run our method for datasets 1 through 5.

## How to run our software to other datasets

## How to use the position-specific features in other analyses
When you run our method, a file named nnfv.txt will be created in the output directory. This file contains information about the position-specific structural features and normalized activity values of each RNA sequence in a two dimensional table. The user can copy this file and use it for various analyses. For example, it can be used as input for various machine learning algorithms. Also, by writing a simple program or using software such as Excel, it is possible to extract RNAs with specific properties. For example, you can get a list of RNAs where a certain position is predicted to be on the right side of the base pair. See below for the format of the nnfv.txt file.　By calculating the mean value of position-specific features for each position, you can obtain the trend of the secondary structure of the input RNA sequences. For example, you can find out that the input RNA sequences tends to have a hairpin loop at a certain position.

## How to use the position-specific features obtained by your own methods (advanced use)
Users can use the position-specific structural features calculated by their own methods as input for our method. This is a very advanced use. For example, suppose a user develops a program to calculate the position-specific structural features using energy parameters other than CONTRAfold, or those features calculated by taking into account the results of SHAPE experiments. The user can use the structural features calculated by that program as input data for our method. This can be done by making the structural features fit the format of the nnfv.txt file. Copy the created nnfv.txt file to the output directory. Then run our program with the -F option. If the header of your own nnfv.txt file is correct, both the text data (w_opt.txt) containing the optimized weights and the image data of it will be created. if the header of the nnfv.txt file is not correct, the image data will not be output, but the text data (w_opt.txt) will be created.

## The format of the nnfv.txt file
This is an example of the nnfv.txt file for the anslysis of single RNA sequences

This is an example of the nnfv.txt file for the anslysis of pairs of RNA sequences

The first and second column are RNA identifier and the normalized activity, respectively. The third and later colums are the position-specific structural features. The header of the third and later columns are differenf between the nnfv.txt file for single RNAs and for pairs of RNAs. 

