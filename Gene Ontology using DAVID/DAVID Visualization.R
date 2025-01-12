library(ggplot2)

# Example DataFrame
annotation_data <- data.frame(
  Cluster = c("1", "2", "3", "4", "5", "6"),
  Enrichment_Score = c(2.30, 1.46, 1.31, 0.98, 0.81, 0.07)
)

# Bar Plot
ggplot(annotation_data, aes(x = Cluster, y = Enrichment_Score, fill = Cluster)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Enrichment Scores of Annotation Clusters",
    x = "Annotation Cluster",
    y = "Enrichment Score"
  ) +
  theme_minimal()

#Go Terms with pathways Networks
# Load library
library(igraph)
# Define edges between GO terms/pathways and key genes
edges <- data.frame(
  from = c("Blood Coagulation", "Hemostasis", "Complement Cascade",
           "Dendrite", "Protein Homodimerization",
           "Exosome", "Endoplasmic Reticulum", "Extracellular Matrix",
           "Apoptotic Process", "Differentiation"),
  to = c("SERPINA1", "PLAU", "PROS1", "LRRK2", "APOE",
         "SERPINA1", "LRRK2", "PLAU", "CHI3L1", "TNFRSF12A")
)

# Create graph
graph <- graph_from_data_frame(edges)

# Plot network
plot(
  graph,
  vertex.color = "skyblue",
  vertex.size = 25,
  vertex.label.color = "black",
  edge.arrow.size = 0.5,
  main = "GO Terms and Pathway Network"
)

#Heatmap of Genes Across the Clusters
# Load library
library(pheatmap)
# Data for genes and clusters
heatmap_data <- matrix(
  c(1, 1, 0, 0, 0, 0,   # SERPINA1
    1, 0, 1, 0, 0, 0,   # PLAU
    1, 0, 0, 0, 1, 0,   # PROS1
    0, 1, 0, 0, 0, 0,   # LRRK2
    0, 1, 1, 0, 0, 0,   # APOE
    0, 1, 0, 0, 0, 0,   # SFTPB
    0, 0, 0, 1, 0, 0,   # CHI3L1
    0, 0, 0, 1, 0, 0,   # TCIM
    0, 0, 0, 0, 1, 0,   # TNFRSF12A
    0, 0, 0, 0, 0, 1),  # CAMK2N1
  nrow = 10,
  byrow = TRUE,
  dimnames = list(
    c("SERPINA1", "PLAU", "PROS1", "LRRK2", "APOE", "SFTPB", "CHI3L1", "TCIM", "TNFRSF12A", "CAMK2N1"),
    c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5", "Cluster 6")
  )
)

# Heatmap
pheatmap(
  heatmap_data,
  color = colorRampPalette(c("lightyellow", "pink"))(50),
  cluster_rows = FALSE,
  cluster_cols = FALSE,
  main = "Gene Involvement in Annotation Clusters",
  display_numbers = TRUE
)

#Bubble plot of key Processes
# Data for bubble plot
bubble_data <- data.frame(
  Process = c("Blood Coagulation", "Hemostasis", "Complement Cascade",
              "Dendrite", "Protein Homodimerization",
              "Exosome", "Endoplasmic Reticulum", "Extracellular Matrix",
              "Apoptosis", "Differentiation"),
  Enrichment_Score = c(2.30, 2.30, 2.30, 1.46, 1.46, 1.31, 1.31, 1.31, 0.98, 0.81),
  Cluster = c(1, 1, 1, 2, 2, 3, 3, 3, 4, 5)
)
# Bubble plot
ggplot(bubble_data, aes(x = Cluster, y = Process, size = Enrichment_Score, fill = as.factor(Cluster))) +
  geom_point(shape = 21) +
  scale_fill_brewer(palette = "Set3") +
  labs(
    title = "Key Processes and Their Enrichment Scores",
    x = "Cluster",
    y = "Process",
    size = "Enrichment Score"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 16))