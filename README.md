# Biomarker Identification in Thyroid Cancer

## Introduction
Thyroid cancer is a significant endocrine malignancy, presenting challenges in differentiating benign from malignant nodules. This project utilizes computational tools to identify potential biomarkers for thyroid cancer, aiding in early diagnosis, prognosis, and personalized treatment.

## Motivation
Current diagnostic methods often yield inconclusive results. This study focuses on leveraging computational methods to analyze publicly available datasets and identify reliable biomarkers. Datasets analyzed include GSE29265, GSE33630, GSE35570, GSE82280, GSE60542, processed with stringent thresholds for FDR and logFC using EdgeR.

## Methodology
1. **Data Preprocessing**:
   - Collected datasets from the Gene Expression Omnibus (GEO).
   - Normalized and cleaned data, mapped probe IDs to gene symbols, and organized samples into tumor and normal conditions.

2. **Differential Expression Analysis**:
   - Identified upregulated DEGs using EdgeR (FDR < 0.02, logFC > 0.2).
   - Visualized results using heatmaps and scatterplots.

3. **Functional Annotation & Enrichment**:
   - Conducted pathway enrichment analysis using DAVID and KEGG.
   - Analyzed protein-protein interaction (PPI) networks with STRING and Cytoscape.

4. **Validation**:
   - Validated biomarkers through survival analysis using GEPIA.

## Key Results
- **Identified Biomarkers**:
  - **APOE**, **APOC1**: Lipid metabolism and immune modulation.
  - **SERPINA1**, **CHI3L1**: Tumor progression and immune regulation.

- **Pathway Associations**:
  - Notch signaling, TGF-beta signaling, and coagulation cascades.

- **Visualizations**:
  - **PCA**: Clear clustering of tumor and normal samples.
  - **UpSet Plot**: Shared and unique DEGs across datasets.
  - **Bubble Plot**: Enriched pathways and biological processes.

## Conclusion
This study integrates bioinformatics tools to identify biomarkers like **APOE**, **APOC1**, **SERPINA1**, and **CHI3L1**, emphasizing their roles in thyroid cancer pathogenesis. These biomarkers provide a foundation for future experimental validation and clinical applications.

## Future Directions
- Integrate multi-omics data (e.g., proteomics, metabolomics).
- Apply machine learning for outcome prediction.
- Conduct clinical trials to validate biomarkers and explore personalized therapies.

## Tools and Resources
- **Tools**: RStudio, DAVID, KEGG, STRING, Cytoscape, GEPIA.
- **Datasets**: 
  - [GSE29265](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE29265)
  - [GSE33630](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE33630)
  - [GSE60542](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE60542)
  - [GSE82208](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE82208)
  - [GSE35570](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE35770)

## References
1. Omicslogic Learn Project - Identification of novel biomarkers for thyroid cancer.
2. Bioinformatics Tutorials: Differential Gene Expression Analysis in R.
3. Tools like DAVID, KEGG, STRING, Cytoscape, and GEPIA for analysis and validation.
