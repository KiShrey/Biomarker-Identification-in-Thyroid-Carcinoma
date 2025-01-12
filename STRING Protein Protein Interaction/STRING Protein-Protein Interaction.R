BiocManager::install("STRINGdb")
library(STRINGdb)
# Create a STRINGdb object
string_db <- STRINGdb$new(version = "11", species = 9606, score_threshold = 400, input_directory = "")

# Define the gene list
my_gene_list <- data.frame(gene = c("SERPINA1", "PLAU", "PROS1", "APOE", "CXCL14", 
                                    "TNFRSF12A", "APOC1", "CHI3L1", "TCIM", 
                                    "LRRK2", "CAMK2N1", "IGSF1", "GABRB2", "GABBR2"))

# Map genes to STRING IDs
mapped_genes <- string_db$map(my_gene_list, "gene", removeUnmappedRows = TRUE)

# Get protein-protein interactions
protein_interactions <- string_db$get_interactions(mapped_genes$STRING_id)

# Filter interactions with a combined score > 700
filtered_interactions <- protein_interactions[protein_interactions$combined_score > 700,]

# Create graph object for visualization
g <- graph_from_data_frame(d = filtered_interactions, directed = FALSE)

# Add vertex labels
V(g)$label <- mapped_genes$gene[match(V(g)$name, mapped_genes$STRING_id)]

# Plot the interaction network
# Enhanced network visualization with igraph
# Adjust layout and add color/size variations for clarity
plot(
  g,
  layout = layout_with_fr(g),               # Fruchterman-Reingold layout for better clustering
  vertex.label = V(g)$label,                # Use gene names as labels
  vertex.size = 25,                         # Larger nodes
  vertex.color = c("skyblue", "lightgreen"), # Color nodes based on clusters
  vertex.label.cex = 0.9,                   # Adjust label size
  edge.width = filtered_interactions$combined_score / 200, # Edge thickness proportional to score
  edge.color = "gray",                      # Set edge color
  main = "Enhanced Protein-Protein Interaction Network"
)

# Install and load ggraph
if (!requireNamespace("ggraph", quietly = TRUE)) install.packages("ggraph")
library(ggraph)

# Enhanced visualization using ggraph
ggraph(g, layout = "fr") +
  geom_edge_link(aes(width = filtered_interactions$combined_score / 200), color = "gray") +
  geom_node_point(aes(color = V(g)$label), size = 10) +
  geom_node_text(aes(label = V(g)$label), repel = TRUE, size = 4) +
  theme_minimal() +
  labs(title = "Enhanced Protein-Protein Interaction Network") +
  theme(plot.title = element_text(hjust = 0.5))

Biological Insights
Cluster 1: APOE, APOC1, SERPINA1, PROS1: These proteins are part of pathways such as complement and coagulation cascades and cholesterol metabolism.
Implications: In thyroid cancer, these proteins may regulate the tumor microenvironment through immune modulation and lipid metabolism changes.

Cluster 2: GABRB2, GABBR2: These proteins are involved in neuroactive ligand-receptor interactions, suggesting their potential role in modulating the tumor microenvironment or neural-like signaling in thyroid cancer.
