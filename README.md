# Mag-Net

This repo contains most of the input files and the basic analyses used in the manuscript "Mag-Net: Rapid enrichment of membrane-bound particles enables high coverage quantitative analysis of the plasma proteome", which is currently located on bioRxiv under the DOI [10.1101/2023.06.10.544439](https://doi.org/10.1101/2023.06.10.544439). Any files not located here are freely and openly accessible on the [Mag-Net page of PanoramaWeb](https://panoramaweb.org/Mag-Net.url). MS data files can also be found on ProteomeXchange under the unique identifier [PXD042947](https://proteomecentral.proteomexchange.org/cgi/GetDataset?ID=PXD042947).

Data was exported using the Skyline document grid. Analyses were perfomed using Skyline, R scripts, R Markdown files, and Jupyter Notebooks.

### Repository Layout

* **KingFisher Methods:** Contains instrument methods for KingFisher System

* **bin:** Contains scripts used to generate figures and preprocessing

* **csv:** Contains csv files used as input and output for the scripts in the bin folder.

* **elibs:** Contains elib files from analysis of the AD/PD data.

$~$


## Scripts

Scripts are located in the **bin** folder.

* **main.r:** R script that orchestrates data wrangling and normalization:

	- R environment (version >= 3.6.0 recommended).
	- Required R packages:
	  - `readr`
	  - `dplyr`
	  - `limma`
	  - `pcaMethods`
	  - `R6`
	- Ensure all required packages are installed before running the script. Use `install.packages("package_name")` to install any missing packages.
	- Usage: navigate to the project directory in your R environment and run the `main.r` script:

		```r
		source("main.r")
  
* **Fig6b.r:** R script that is used to generate the following figure panels:

  - Figure 6B
  
* **Fig6c.r:** R script that is used to generate the following figure panels:

  - Figure 6C
  
* **Fig6d.r:** R script that is used to generate the following figure panels:

  - Figure 6D

* **Fig7b_Fig7c.ipynb:** Jupyter Notebook including machine learning that is used to generate the following figure panels:

  - Figure 7B
  - Supplementary figure S12

* **Fig2c_Fig4a_Fig4b.r:** R script that is used to generate the following figure panels:

  - Figure 3C
  - Figure 4A
  - Figure 4B
  - Figure 7A

* **Figs_2C_3A_3B_5B__SuppFigs_S1_S5_S6.Rmd:** R Markdown file that is used to generate the following figure panels:

   - Figure 2C
   - Figure 3A
   - Figure 3B
   - Figure 5B
   - Supplementary Figure S2
   - Supplementary Figure S7
   - Supplementary Figure S8

* **Fig_7C__SuppFigs_S7_S8_S9.Rmd:** R Markdown file that is used to generate the following figure panels:

   - Figure 7C
   - Supplementary Figure S9
   - Supplementary Figure S10
   - Supplementary Figure S11

* **SuppFig_S3.Rmd:** R Markdown file that is used to generate the following figure panels:

   - Supplementary Figure S3

     
$~$


## Files

Input files for scripts are located in the **csv** folder. Any necessary input files that are too large to be uploaded to GitHub are freely accessible on the [Mag-Net page of PanoramaWeb](https://panoramaweb.org/Mag-Net.url).

### main.r input files

#### ***Skyline Document:*** Particles-ADPD-Pilot-EncV2score-QuantReport_2023-03-05_17-26-00.sky.zip

* **EV_ADPD_Protein_Total_Areas.csv:** Skyline document grid output of protein abundance from AD/PD experiment.
* **TPAD HC_AD_PDD_PD-noMCI Plasma - Metadata.csv:** Skyline document grid output of user-defined metadata for AD/PD experiment.

### Fig6b.r input files

#### ***Skyline Document:*** Particles-ADPD-Pilot-EncV2score-QuantReport_2023-03-05_17-26-00.sky.zip

* **EV_ADPD_Peptide_Total_Areas.csv:** Skyline document grid output of peptide abundance from AD/PD experiment.
* **TPAD HC_AD_PDD_PD-noMCI Plasma - Metadata.csv:** Skyline document grid output of user-defined metadata for AD/PD experiment.

$~$
  
### Fig6c.r input files

#### ***Skyline Document:*** Particles-ADPD-Pilot-EncV2score-QuantReport_2023-03-05_17-26-00.sky.zip

* **EV_ADPD_Peptide_Total_Areas.csv:** Skyline document grid output of peptide abundance from AD/PD experiment.
* **TPAD HC_AD_PDD_PD-noMCI Plasma - Metadata.csv:** Skyline document grid output of user-defined metadata for AD/PD experiment.

$~$
  
### Fig6d.r input files

#### ***Skyline Document:*** Particles-ADPD-Pilot-EncV2score-QuantReport_2023-03-05_17-26-00.sky.zip

* **EV_ADPD_Peptide_Total_Areas.csv:** Skyline document grid output of peptide abundance from AD/PD experiment.
* **EV_ADPD_Protein_Total_Areas.csv:** Skyline document grid output of protein abundance from AD/PD experiment.
* **TPAD HC_AD_PDD_PD-noMCI Plasma - Metadata.csv:** Skyline document grid output of user-defined metadata for AD/PD experiment.

$~$

### Fig7b_Fig7c.ipynb input files

#### ***Skyline Document:*** Particles-ADPD-Pilot-EncV2score-QuantReport_2023-03-05_17-26-00.sky.zip

* **20230812-particlesADPD_pilot-nobatchProt4.csv:** Skyline document grid output of protein abundance from AD/PD experiment.
* **TPAD HC_AD_PDD_PD-noMCI Plasma - Metadata.csv:** Skyline document grid output of user-defined metadata for AD/PD experiment.

$~$

### Fig2c_Fig4a_Fig4b.r input files

#### ***Skyline Document:*** SAX-EV vs OH PAC-Plasma-EncV2score_2023-06-02_10-52-08.sky.zip

* **Sample 14-Particle Distribution.csv:** Size distribution of particles isolated from human plasma by Mag-Net (Figure 3C). Measurements obtained using Nanosight NS300 and analyzed in Nanosight Nanoparticle Tracking Analysis software (Malvern Panalytical Ltd).
* **EV and Plasma Protein Total Areas.csv:** Protein areas used to generate the panels depicting the dynamic range of the plasma proteome (Figure 4A and 4B).

$~$

### Figs_2C_3A_3B_5B__SuppFigs_S1_S5_S6.Rmd input files 

#### ***Skyline Document:*** SAX-EV vs OH PAC-Plasma-EncV2score_2023-06-02_10-52-08.sky.zip

* **Protein_List.csv:** Table used to extract and label of proteins of interest highlighted in Enrichment/Depletion plots (Figure 3A and 3B), in the volcano plot annotated with specific extracellular vesicle markers and common plamsa proteins. (Supplementary Figure S1), and AD/PD box plots (Figure 7C, Supplementary Figure S7-S9).

* **group-fc-Beads-SAXN-Particles vs HydN-Plasma-EncV2score-QuantReport_2023-03-05_13-29-41.csv:** Skyline document grid output comparing SAX bead Mag-Net enriched fraction to Hydroxyl bead SP3-prepared total plasma samples. Used to generate the volcano plot with protein number annotations (Figure 2C), Enrichment/Depletion plots (Figure 3A and 3B), and in the volcano plot annotated with specific extracellular vesicle markers and common plamsa proteins. (Supplementary Figure S1).

#### ***Skyline Document:*** EV-Matrix Matched Cal Curve_2023-05-24_16-33-15.sky.zip

* **MMCC_EV_Eclipse_Protein_Long_ProtAb_NoNorm.csv:** Skyline document grid output of protein abundance without normalization applied.

* **MMCC_EV_Eclipse_figuresofmerit_proteins_NoNorm.csv:** Limits of quantitation (LOQ) and Limits of Detection (LOD) generated using variation of python script "calculate_loq.py" in github repo [iontrap_vs_orbitrap](https://github.com/uw-maccosslab/iontrap_vs_orbitrap) used in Supplementary Figure S5.

* **MMCC_EV_Eclipse_files_meta.csv:** Skyline document grid output of user-defined metadata for MMCC experiment.

* File located only on PanoramaWeb
  - **MMCC_EV_Eclipse_Peptide_Long_TAF_NoNorm.csv:** File needed for Matrix-Matched Calibration Curve analysis (Figure 5B). Located in the "Reports" folder under **Supplementary Files** on the [Mag-Net page of PanoramaWeb](https://panoramaweb.org/Mag-Net.url).

#### ***Skyline Document:*** Particles-FreezeThaw-EncV2score-QuantReport_2023-03-05_14-48-57.sky.zip
* File located only on PanoramaWeb
  - **FT_TICnormalized_LongForm_Peptide_NormArea_Long.csv"** Skyline document grid output of peptide normalized area without normalization applied (Supplementary Figure S6). Located in the "Reports" folder under **Supplementary Files** on the [Mag-Net page of PanoramaWeb](https://panoramaweb.org/Mag-Net.url).

* **FT_LongForm_Reps_Meta.csv:** Skyline document grid output of user-defined metadata for freeze-thaw experiment.

$~$

### Fig_7C__SuppFigs_S7_S8_S9.Rmd input files 

#### ***Skyline Document:*** Particles-ADPD-Pilot-EncV2score-QuantReport_2023-03-05_17-26-00.sky.zip

* **20230812-particlesADPD_pilot-batchadj-Prot.csv:** Normalized protein abundance generated in post-processing.

* **mag-net_biomarker_rocs-final.csv:** ROC values generated in post-processing.

* **TPAD HCN_ADD_PDD_PDCN Plasma - Metadata.csv:** Skyline document grid output of user-defined metadata for AD/PD experiment.

* **Protein_List.csv:** Table used to extract and label of proteins of interest highlighted in Enrichment/Depletion plots (Figure 3A and 3B), in the volcano plot annotated with specific extracellular vesicle markers and common plamsa proteins. (Supplementary Figure S1), and AD/PD box plots (Figure 7C, Supplementary Figure S7-S9).

$~$

### SuppFig_S3.Rmd input files 

#### ***Skyline Document:*** SAX-EV vs OH PAC-Plasma-EncV2score_2023-06-02_10-52-08.sky.zip

* **2024May31_EnrichDeplet_TIC_FCtype.csv:** Dated output from **Figs_2C_3A_3B_5B__SuppFigs_S1_S5_S6.Rmd** with fold changes of Mag-Net enriched fraction relatice to matched total undepleted plasma.

* **EXOCARTA_PROTEIN_MRNA_DETAILS_5_2024_06_18.csv:** List of proteins and mRNA data downloaded from the ExoCarta database on June 18, 2024. 

* **EXOCARTA_PROTEIN_MRNA_DETAILS_5_idmapping_2024_06_18.csv:** Protein list filtered from ExoCarta database after matching associated gene names to UniProt Accession Numbers.


$~$


## Figure Generation

Details of script used broken down for each figure panel.

* Figure 1:
  - **1A:** Mag-Net approach schematic. Generated in an image processor. No script or files on github.
  - **1B:** Mag-Net method schematic. Generated in an image processor. No script or files on github.

* Figure 2:
  - **2A:** Peptide detections using different analytical pipelines. No script or files on github.
  - **2B:** Protein detections using different analytical pipelines. No script or files on github.
  - **2C:** Volcano plot annotated with protein counts. Panel and protein counts generated in "Figs_2C_3A_3B_5B__SuppFigs_S1_S5_S6.Rmd". Protein counts manually added using image processor.
  - **2D:** Image of top 10 Jensen Compartments from Enrichr tool. No script or files on github.

* Figure 3:
  - **3A:** Enriched EV markers. Panel generated in "Figs_2C_3A_3B_5B__SuppFigs_S1_S5_S6.Rmd".
  - **3B:** Depleted common plasma proteins. Panel generated in "Figs_2C_3A_3B_5B__SuppFigs_S1_S5_S6.Rmd".
  - **3C:** Particle count distribution. Panel generated in "Fig2c_Fig4a_Fig4b.r".
  - **3D:** TEM image collected using a JEOL 1230 Transmission Electron Microscope (Peabody, MA). No script or files on github.

* Figure 4:
  - **4A:** Dynamic range of the plasma proteome - plasma digestion. Panel generated in "Fig2c_Fig4a_Fig4b.r" and location of protein text labels manually optimized in image processor for better visualization.
  - **4B:** Dynamic range of the plasma proteome - Mag-Net enrichment. Panel generated in "Fig2c_Fig4a_Fig4b.r" and location of protein text labels manually optimized in image processor for better visualization.

* Figure 5:
  - **5A:** MMCC visual summary. Generated in an image processor. No script or files on github.
  - **5B:** Half-violin/ box plot of all peptides in MMCC experiment. Panel generated in "Figs_2C_3A_3B_5B__SuppFigs_S1_S5_S6.Rmd".

* Figure 6:
  - **6A:** Schematic describing dementia cohort. Generated in an image processor. No script or files on github.
  - **6B:** Plotting peptide detections and FDR levels in each experimental and quality control sample. Panel generated in "Fig6b.r".
  - **6C:** Log2 peptide abundance of replicate Mag-Net preparation. Panel generated in "Fig6c.r".
  - **6D:** Effect of data processing on CVs. Panel generated in "Fig6d.r".

* Figure 7:
  - **7A:** Heatmap of proteins with ROC > 0.7 from 6 pairwise analyses. Panel generated in "Fig2c_Fig4a_Fig4b.r".
  - **7B:** Example receiver operator characteristic (ROC) curve. Panel generated in "Fig7b_Fig7c.ipynb".
  - **7C:** Panel of protein-level box plots annotated with ROC and q-value of 10 proteins that were found to be specifically increased in ADD. Panel generated in "Fig_7C__SuppFigs_S7_S8_S9.Rmd".
  
* Supplementary Figure S1:
  - Method figure illustrating the two cycle Mag-Net protocol versus the single cycle total plasma PAC protocol. No script or files on github.

* Supplementary Figure S2:
  - Volcano plot annotated with specific extracellular vesicle markers and common plamsa proteins. Panel generated in "Figs_2C_3A_3B_5B__SuppFigs_S1_S5_S6.Rmd".

* Supplementary Figure S3:
  - **S3A:**  Histogram of the fold-changes of the 729 proteins found in Mag-Net that matched with any of the top 1000 proteins by abbundance in the ExoCarta human protein/mRNA database. Panel generated in "SuppFig_S3.Rmd".
  - **S3B:**  Histogram of the fold-changes of the 100 proteins found in Mag-Net that matched with any of the top 100 proteins by abbundance in the ExoCarta human protein/mRNA database. Panel generated in "SuppFig_S3.Rmd".
  - **S3C:**  Labeled volcano plot of the fold-changes of the 729 proteins found in Mag-Net that matched with any of the top 1000 proteins by abbundance in the ExoCarta human protein/mRNA database. Labeled top 15 most frequently identified proteins that are enriched, and the 5 most frequently identified proteins that are depleted in Mag-Net. Panel generated in "SuppFig_S3.Rmd".
  - **S3D:**  Labeled volcano plot of the fold-changes of the 100 proteins found in Mag-Net that matched with any of the top 1000 proteins by abbundance in the ExoCarta human protein/mRNA database. Labeled top 15 most frequently identified proteins that are enriched, and the only 3 most frequently identified proteins that are depleted in Mag-Net. Panel generated in "SuppFig_S3.Rmd".
    
* Supplementary Figure S4:
  - Image of volcano plot exported from Skyline comparing hydroxyl and SAX beads on the same unfractionated plasma.
    
* Supplementary Figure S5:
  - **S5A:**  Image of volcano plot exported from Skyline comparing total plasma digested using hydroxyl beads and the same plasma processed with Mag-Net using hydroxyl beads. No script or files on github.
  - **S5B:**  Image of top 10 Jensen Compartments. No script or files on github.
 
* Supplementary Figure S6:
  - **S6A:**  Image of top 10 GO terms in Hydroxyl bead Mag-Net capture. No script or files on github.
  - **S6B:**  Image of volcano plot exported from Skyline comparing plasma processed with Mag-Net using both hydroxyl and SAX beads. No script or files on github.
  - **S6C:**  Image of top 10 GO terms in SAX bead Mag-Net capture. No script or files on github.

* Supplementary Figure S7:
  - **S7A:** MMCC visual summary. Generated in an image processor. No script or files on github.
  - **S7B:** CD9 - Protein abundance of replicate injections exported from Skyline document grid. Limit of quantitation (LOQ), and Limit of Detection (LOD) calculated using variation of python script "calculate_loq.py" in github repo [iontrap_vs_orbitrap](https://github.com/uw-maccosslab/iontrap_vs_orbitrap). Panel generated in "Figs_2C_3A_3B_5B__SuppFigs_S1_S5_S6.Rmd".
  - **S7C:** NCAM1 - Protein abundance of replicate injections exported from Skyline document grid. Limit of quantitation (LOQ), and Limit of Detection (LOD) calculated using variation of python script "calculate_loq.py" in github repo [iontrap_vs_orbitrap](https://github.com/uw-maccosslab/iontrap_vs_orbitrap). Panel generated in "Figs_2C_3A_3B_5B__SuppFigs_S1_S5_S6.Rmd".
  - **S7D:** CD9 - Protein abundance of replicate injections exported from Skyline document grid. Limit of quantitation (LOQ), and Limit of Detection (LOD) calculated using variation of python script "calculate_loq.py" in github repo [iontrap_vs_orbitrap](https://github.com/uw-maccosslab/iontrap_vs_orbitrap). Panel generated in "Figs_2C_3A_3B_5B__SuppFigs_S1_S5_S6.Rmd".

* Supplementary Figure S8:
  - Half-violin/ box plot of all peptides in FT experiment. Panel generated in "Figs_2C_3A_3B_5B__SuppFigs_S1_S5_S6.Rmd".
 
* Supplementary Figure S9:
  - Panel of protein-level box plots annotated with ROC and q-value of 12 proteins that were found to be specifically increased in ADD and involved in vesicle mediated transport. Panel generated in "Fig_7C__SuppFigs_S7_S8_S9.Rmd".
 
* Supplementary Figure S10:
  - Panel of protein-level box plots annotated with ROC and q-value of 8 proteins that were found to be specifically increased in ADD and are involved in lipid metabolism. Panel generated in "Fig_7C__SuppFigs_S7_S8_S9.Rmd".
 
* Supplementary Figure S11:
  - Panel of protein-level box plots annotated with ROC and q-value of 16 proteins that were found to be specifically increased in ADD and are involved in Ubiquitin-proteasome mediated protein degradation. Panel generated in "Fig_7C__SuppFigs_S7_S8_S9.Rmd".
 
* Supplementary Figure S12:
  - Panel of 5 ROC curves illustrating development of an SVM classifier. Panel generated in "Fig7b_Fig7c.ipynb".
