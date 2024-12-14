# EE282 Final Project
#### Garnet Phinney


 # Introduction

*Drosophila affinis* has a unique transposon landscape, with its TE families having a higher population frequency than those in *Drosophila melanogaster* (Hey 1989). Despite this interesting phenomena, the TE landscape of *Drosophila affinis* has not been investigated using modern day genomics tools. Transposable elements (TEs) are selfish mobile genetic elements that repetitively insert themselves into the genome via molecular intermediates (Cosby et al. 2019). Despite TEs making up a large portion of Eukaryotic genomes, they are often deleterious towards their hosts, disrupting genes and regulatory pathways, and triggering epigenetic silencing (Cosby et al. 2019). TEs can be classified by family, where TEs in the same family were originated by the same TE ancestor (Wells and Feschotte 2020). Constructing phylogenies of TE families can help explain their evolutionary histories (Wells and Feschotte 2020). While transposable elements play a substantial role in eukaryotic genomes, there is much that remains unknown regarding their function, and there are species whose genomes lack thorough TE annotation. 
*Drosophila melanogaster*, commonly known as the fruit fly, is a model organism that has been the subject of many studies regarding transposable elements (Cosby et al. 2019).

 While there is much documentation on the TE landscape in *Drosophila melanogaster*, there is less information on the TE landscapes of related species of *Drosophila*. Understanding the TE landscapes of these related species would provide a point of comparison for *Drosophila melonegaster’s* TEs, and could give insight into what evolutionary pressures cause TE abundance to increase in populations. Previous work suggests unusual TE activity in species related to *Drosophila melanogaster* (Hey 1989), but there is a lack of additional studies further exploring this finding. In order to revisit this finding, it is first necessary to uncover which bioinformatics tools create the most accurate TE consensus libraries and genome annotations. In this project we use a combination of contemporary bioinformatics tools on a recently sequenced *Drosophila affinis* reference genome to uncover which combination of contemporary tools produce the most comprehensive consensus libraries and the least amount of fragmented annotations. 

# Methods

## Iterations of EarlGrey and TEtrimmer

The *Drosophila affinis* reference genome assembly was downloaded from the NCBI genome database (https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_037356375.1/). The reference transposon library for *Drosophila* was obtained from the drosophila-transposons GitHub repository from the Bergman lab at the University of Georgia (Bergman 2021 "https://github.com/bergmanlab/drosophila-transposons/). Though there are multiple *Drosophila* transposon libraries in existence, for simplicity this paper will refer to the *Drosophila* transposon library obtained from the Bergman lab the “*Drosophila* transposon library”.

To better understand the successes and limitations of each potential pipeline, various combinations of the TE curation tools EarlGrey (Baril 2024) and TEtrimmer (Qian 2024) were run, all with their reference genome set to *Drosophila affinis*. Some runs were given the *Drosophila* transposon library, others were given the output libraries from their previous steps, and one EarlGrey run generated a transposon library using the *Drosophila* NCBI ID as a RepeatMasker search term. In total, EarlGrey and TEtrimmer were run three times each, with two distinct runs of TEtrimmer using EarlGrey output as its input transposon library, and one run of EarlGrey using TEtrimmer output as its input transposon library. Scripts for each run are available in code/scripts, and a detailed schematic of each of the permutations of Tetrimmer and EarlGrey is provided in Figure 1. Each run is numbered for ease of reference in the following sections. 

Due to TEtrimmer’s advancements with building consensus libraries (Qian 2024), and EarlGreys superior capabilities in reducing fragmented annotations (Baril 2024), we expect that combining these tools will produce the most accurate TE annotations.

![image](https://github.com/user-attachments/assets/6cf8644b-42b7-4f25-b840-a5c9449f549b)
Figure 1: Workflow of Processes

## Application of Course Concepts
This project applied concepts learned in the EE282 course, which can be viewed in code/scripts and code/analysis. These concepts include creating bash scripts and submitting batch jobs (all .sh scripts), using R to produce detailed summary plots (EGfamilycomparisonplots), and using Boolean operators for data wrangling (LengthReductionCalc.R). 


# Results

## EarlGrey: Repeat Classification

Figure 2a-c displays a summary pie chart of the transposon class composition of each run of EarlGrey. Notably, the “Other (Simple repeat, microsatellite, RNA)” portion is the largest in run 1, where EarlGrey ran with the RepeatMasker search term set to the *Drosophila* NCBI taxonomy ID. This portion is smaller in the run where EarlGrey was provided the *Drosophila* transposon library, and the smallest when provided the TEtrimmer consensus library (which ran on the *Drosophila* transposon library). Much of the section that was classified as “Other” in run 1 seems to have been reclassified as “Non-Repeat” in runs 2 and 6. This suggests that providing EarlGrey with the transposon library is more precise for TE family detection compared to providing EarlGrey with the RepeatMasker search term, and that running TEtrimmer on the transposon library prior to Earl Grey is the most precise. It should be noted that for run 1, the option -m to remove annotations <100bp was not selected, which also may contribute to run 1’s increased “Other” portion.

![image](https://github.com/user-attachments/assets/ff654dc1-6dbe-4794-82ef-56ed6751adbb)
Figure 2a: EarlGrey summary pie charts of transposon class composition
![image](https://github.com/user-attachments/assets/91714211-edfd-4d82-aeb5-6126478292cc)
Figure 2b: EarlGrey summary pie charts of transposon class composition
![image](https://github.com/user-attachments/assets/757989f4-5f8a-40be-bea9-06aab63d8a99)
Figure 2c: EarlGrey summary pie charts of transposon class composition



## EarlGrey: TE Family Copy Number

To understand how the starting input of Earlgrey impacts how it categorizes TE families, we used the EarlGrey output file “family level count summary” to plot the results of its three runs (script: EGfamilycomparisonplots.R). Figure 3 depicts the genome coverage for each TE family copy recognized by EarlGrey in each of its three runs. Looking at Figure 3, it is clear that giving EarlGrey the *Drosophila* transposon library as opposed to a RepeatMasker search term greatly impacts its identification of TE families. In Run 1, where EarlGrey is given only reference to the *Drosophila* taxonomy ID, there are many TE families with copy numbers above 2,500 copies. It should be noted that for run 1, the option -m to remove annotations <100bp was not selected, which also likely contributes to this result. In Run 2, where EarlGrey is given the *Drosophila* TE library, there are no TE families with a copy number above 2,500. In Run 6, where EarlGrey is run on the output TEtrimmer library (which ran on the *Drosophila* transposon library), we also see no family copy numbers above 2,500, and we see the highest purported genome coverage for a single TE family. This further supports the findings of Figure 2a-c,  that giving EarlGrey the *Drosophila* transposon library greatly reduces TE family fragmentation, and that the refining the *Drosophila* transposon library with TEtrimmer prior to running EarlGrey produces the least amount of fragmentation. It is likely that an input library first being processed by TEtrimmer prevents EarlGrey from labeling single TE families as multiple smaller families. 
        

![image](https://github.com/user-attachments/assets/ca18de5c-e926-4c9b-853e-0dd930e52c50)
Figure 3: Genome coverage per TE family


## TEtrimmer: Sequence Length Reduction

One of TEtrimmers stated benefits is reducing trailing sequences to create more accurate TE boundary definitions (Qian 2024). To evaluate the comparative effectiveness of TEtrimmer in each run, we calculated the percent reduction of consensus library sequence length compared to input library sequence length (script: “LengthReductionCalc”). Any sequences that were skipped by TEtrimmer were not factored into our calculation. These results are available for reference in Table 1. 


| Run                       | Average Reduction in Sequence Length |
| ----------------------------------------------------|--------------------------------------|
| 5. Tetrimmer on EGL (EG given Drosophila TEL)       |  19.565% 
| 4. Tetrimmer on EGL (EG Repeat Masker search term Drosophila) | 18.37678%  |
| 3. TEtrimmer on Drosophila TEL | 4.765855% |


Both iterations of TEtrimmer on an EarlGrey library had a similar average reduction in sequence length. Interestingly, TEtrimmer produced a slightly greater sequence length reduction when EarlGrey was given the *Drosophila* transposon library for an initial mask compared to when EarlGrey was given the Repeat Masker search term for Drosophila. There is a notable decrease in the percent sequence length reduction for TEtrimmer running on the *Drosophila* transposon library with no EarlGrey step performed. This is expected, as EarlGrey can locate de novo TE sequences even when given a starting library (Baril 2024), and these sequences have not undergone the same level of curation as the *Drosophila* transposon library. It is promising that running TEtrimmer on the Drosophila transposon library resulted in the low average sequence length reduction of less than 5%. This indicates that the *Drosophila* transposon library is well curated, and also acts as a negative control, showing that TEtrimmer is not spuriously reducing well curated sequences. Trimming overextended TE sequences will be a necessary step for building a high quality Drosophila affinis TE consensus library. 

## TEtrimmer: TE Family Clusters

For every TE cluster, TEtrimmer produces detailed report plots (Qian 2024). Though considering all of TEtrimmer’s output for every run is outside of the scope of this project, these plots should be noted due to their utility for manual curation. For reference on the utility of TEtrimmer’s output, select output summary files for run #5 are included in the output section of the affinis GitHub repository. A portion of an output file for a Pao TE cluster identified in run #3 is depicted in Figure 4a-c for reference. Notably, Figure 4c shows the result of TEtrimmer combining multiple small open reading frames into one larger one. This reduction of fragmentation is important for achieving high quality annotations (Qian 2024). This is also consistent figure 2, which shows that EarlGrey’s output library had the highest coverage when its input had first undergone a round of TEtrimmer. 


<img width="935" alt="image" src="https://github.com/user-attachments/assets/2ff060b8-ae0b-406f-9a95-c07bd559b3d7" />
Figure 4a: Tetrimmer MSA for curation



<img width="1100" alt="image" src="https://github.com/user-attachments/assets/b726501b-7aba-4428-8095-d9ab2e7efcb1" />
Figure 4b: TEtrimmer before and after plots  

  

 

<img width="673" alt="image" src="https://github.com/user-attachments/assets/e061bbe3-53f1-45ec-9154-234f9fc4ede8" />
Figure 4c: TEtrimmer before and after ORF and PFAM plot





# Discussion


Our results provide a preliminary understanding of which combination of methods produce the most accurate transposon consensus library in *Drosophila affinis*. In the future more analysis will be done to determine whether the -m option in EarlGrey has impacted Run 1’s output. This will be analyzed by producing a negative control in the form of running EarlGrey entirely de novo on the *Drosophila affinis* reference genome. Manual curation will also be performed on TEtrimmer output to determine the impact manual curation has on TEtrimmer’s final consensus library and its downstream uses. Understanding the successes and limitations of each workflow will allow us to choose the best method for creating a modern site frequency spectrum of *Drosophila affinis*.


# References

Baril T, Galbraith J, Hayward A,  2024. Earl Grey: A Fully Automated User-Friendly 
Transposable Element Annotation and Analysis Pipeline, Mol Biol Evol, 4(4). DOI: https://doi.org/10.1093/molbev/msae068.
 Bergman C et al. 2021. "Drosophila transposon canonical sequences". GitHub: 
"https://github.com/bergmanlab/drosophila-transposons/"

Cosby RL, Chang NC, Feschotte C. 2019. Host-transposon interactions: conflict, 
cooperation, and cooption. Genes Dev. 33(17-18): 1098-1116. DOI: 10.1101/gad.327312.119. 

Hey J. 1989. The transposable portion of the genome of Drosophila algonquin is very 
different from that in D. melanogaster. Mol Biol Evol. 6(1): 66-79. DOI: 10.1093/oxfordjournals.molbev.a040530. PMID: 2537921.

Qian J, Xue H, Ou S, Storer J, Fürtauer L, Wildermuth M, Kusch S, Panstruga R. 2024. 
TEtrimmer: a novel tool to automate the manual curation of transposable elements. bioRxiv. DOI: https://doi.org/10.1101/2024.06.27.600963.

Smit AFA, Hubley R, Green P. 2013-2015. RepeatMasker Open-4.0.
http://www.repeatmasker.org.

Unckless R.L. 2024. Genome assembly KU_Daffinis_5.1. NCBI. Genbank Assembly: GCA_037356375.1.
https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_037356375.1/.

Wells J. and Feschotte C. 2020. A Field Guide to Eukaryotic Transposable Elements. 
Annual Reviews. 54: 539-561. DOI: 10.1146/annurev-genet-040620-022145.







