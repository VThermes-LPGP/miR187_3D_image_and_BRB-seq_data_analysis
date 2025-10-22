**BRB-seq transcriptomic analysis**, performed to compare gene expression profiles between *miR-187⁻/⁻* mutants and wild-type (WT) medaka ovaries, and to identify potential miR-187-3p targets involved in ovarian function.

Raw read alignment and gene quantification were carried out using the [Nextflow RNAseq pipeline](https://forgemia.inra.fr/lpgp/rnaseq), developed and maintained by the INRAE LPGP bioinformatics team. This automated workflow includes: Transcriptome alignment and quantification with *Alevin-fry* ([PMID: 37034702](https://pubmed.ncbi.nlm.nih.gov/37034702/)) via its simpleaf wrapper, and Genome alignment and exon-level quantification with *STARsolo* ([PMID: 23104886](https://pubmed.ncbi.nlm.nih.gov/23104886/)). Execution was performed on an HPC cluster using SLURM job scheduling, following the pipeline configuration. The resulting gene-level count matrices were used for downstream analyses described below.

Differential gene expression + KEGG pathway analysis:  
Normalized gene counts (≥10 reads per gene in at least four samples per condition) were analyzed using DESeq2 (PMID: 25516281) to identify genes significantly differentially expressed between miR-187⁻/⁻ and WT groups (adjusted p < 0.05). In this part, the codes included vizualization of the DEGs through volcano plots for overall DEG distribution, Principal Component Analysis (PCA) for sample clustering, and Hierarchical clustering heatmaps (HCL) showing co-expression patterns using Pearson correlation (genes) and Euclidean distance (samples) with Ward.D2 linkage.
Significant DEGs were further analyzed for functional enrichment using KEGG pathway analysis, enabling the identification of biological pathways and molecular processes affected by miR-187 disruption.

Identification of potential miR-187-3p targets:  
Candidate targets of miR-187-3p were identified using an *in silico* filtering approach adapted from *Janati-Idrissi et al.*
Genes were retained based on the following criteria: Predicted 7mer–8mer binding sites (*TargetScan*), Mild up-regulation (*0 < log₂FC < 1*), Low inter-individual variability in WT (*IVV₍WT₎ < FC₍Mut/WT₎*), and Increased variability in mutants (*CV₍Mut₎ > 1.1 × CV₍WT₎*). 
This filtering strategy highlights genes potentially regulated by miR-187-3p and contributing to the ovarian phenotype observed in *miR-187⁻/⁻* females.
