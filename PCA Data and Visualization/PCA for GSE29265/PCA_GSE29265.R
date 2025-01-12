# Load required libraries
library(ggplot2)
library(readxl)

# Read data from Excel file
file_path <- "C:/Users/kshreyaa/Downloads/PCA_Data_GSE29265.xlsx"
# Load sheets
normalized_counts <- read_excel(file_path, sheet = "Normalized_Counts")
group_info <- read_excel(file_path, sheet = "Group_Info")

# Transpose Normalized_Counts and prepare the matrix
rownames(normalized_counts) <- normalized_counts$Gene
normalized_counts <- normalized_counts[,-1]  # Remove Gene column
data_t <- t(normalized_counts)  # Transpose the data

# Remove the "Gene" row from transposed data
data_t <- data_t[!rownames(data_t) %in% "Gene", ]
str(data_t)
print(data_t)

# Match groups with sample names
samples_in_data <- rownames(data_t)
print(samples_in_data)
samples_in_group_info <- group_info$Sample
print(samples_in_group_info)

# Ensure both datasets have matching samples
matching_indices <- match(samples_in_data, samples_in_group_info)

# Check for any unmatched samples
if (any(is.na(matching_indices))) {
  stop("Some samples in data_t do not match the Group_Info sheet. Check for mismatches.")
}

# Subset group_info to match data_t samples
group_info <- group_info[matching_indices,]

# Remove any rows or columns that are not numeric
data_t <- apply(data_t, 2, as.numeric)
# Standardize the data
data_scaled <- scale(data_t)

# Perform PCA
pca <- prcomp(data_scaled, center = TRUE, scale. = TRUE)

# Create a data frame with PCA results
pca_results <- as.data.frame(pca$x)

# Add group information to PCA results
pca_results$Group <- group_info$Group

# Plot the PCA results
ggplot(pca_results, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(
    title = "PCA of Gene Expression Data",
    x = paste0("PC1 (", round(summary(pca)$importance[2, 1] * 100, 1), "% Variance)"),
    y = paste0("PC2 (", round(summary(pca)$importance[2, 2] * 100, 1), "% Variance)")
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16),
    axis.title = element_text(size = 12)
  )