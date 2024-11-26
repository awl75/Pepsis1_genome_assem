# Pepsis1 assembly stats
library(dplyr)
library(ggplot2)

# original file avg_coverage_per_contig_HiFi_p_ctg_align.sorted.bam.txt
# import file with contig names and avg genomic read coverage values
avg_cov_cont_p <- read.delim(file="/Users/andrewlegan/Documents/Documents - Andrew’s MacBook Pro/Pepsis1/table_avg_coverage_per_contig_HiFi_p_ctg_align.sorted.bam.txt")
head(avg_cov_cont_p)
colnames(avg_cov_cont_p) <- c("contig_name", "cov")

# import file with contig names, len, %GC content
cont_p_GC_len <- read.delim(file="/Users/andrewlegan/Documents/Documents - Andrew’s MacBook Pro/Pepsis1/Pepsis1_GC_len_p_ctg.txt", sep = "\t")
head(cont_p_GC_len)

# merge to add cov to table (1 contig is missing from cov)
contig_stats <- cont_p_GC_len %>%
  left_join(avg_cov_cont_p, by = "contig_name")
head(contig_stats)

# 100 longest contigs
# Subset the top 100 longest scaffolds
top_100_contigs_Pepsis1 <- contig_stats %>%
  arrange(desc(seq_len)) %>%
  slice_head(n = 100)  # Select the first 100 rows (longest scaffolds)

#1. Histogram of contig lengths
ggplot(contig_stats, aes(x = seq_len / 1e6)) +
  geom_histogram(bins = 500, fill = "skyblue", color = "black") +
  scale_x_continuous(
    limits = c(-0.05, NA),  # Start at 0, let ggplot set the upper limit
    expand = expansion(mult = c(0, 0.05)),  # Add a small space at the ends
    breaks = scales::pretty_breaks(n = 24)  # More ticks
  ) +
  scale_y_continuous(
    limits = c(0, NA),  # Start y-axis at 0
    expand = expansion(mult = c(0, 0.05)),  # Add small margin on top
    breaks = scales::pretty_breaks(n = 10)  # Adjust ticks on y-axis
  ) +
  labs(title = "Distribution of Contig Lengths",
       x = "Contig Length (Mb)",
       y = "Frequency") +
  theme(
  text = element_text(color = "black"),
  axis.text = element_text(color = "black"),
  axis.title = element_text(color = "black"),
  plot.title = element_text(color = "black", hjust = 0.10),
  legend.text = element_text(color = "black"),
  legend.title = element_text(color = "black"),
  panel.background = element_blank(),
  plot.background = element_blank(),
  panel.grid.major = element_line(color = "lightgray", size = 0.5),
  panel.grid.minor = element_line(color = "lightgray", size = 0.25),
  axis.line = element_line(color = "black")
)

#1b. Histogram of top 100 contig lengths
ggplot(top_100_contigs_Pepsis1, aes(x = seq_len / 1e6)) +
  geom_histogram(bins = 500, fill = "skyblue", color = "black") +
  scale_x_continuous(
    limits = c(-0.05, NA),  # Start at 0, let ggplot set the upper limit
    expand = expansion(mult = c(0, 0.05)),  # Add a small space at the ends
    breaks = scales::pretty_breaks(n = 24)  # More ticks
  ) +
  scale_y_continuous(
    limits = c(0, NA),  # Start y-axis at 0
    expand = expansion(mult = c(0, 0.05)),  # Add small margin on top
    breaks = scales::pretty_breaks(n = 10)  # Adjust ticks on y-axis
  ) +
  labs(title = "Distribution of Top 100 Contig Lengths",
       x = "Contig Length (Mb)",
       y = "Frequency") +
  theme(
    text = element_text(color = "black"),
    axis.text = element_text(color = "black"),
    axis.title = element_text(color = "black"),
    plot.title = element_text(color = "black", hjust = 0.10),
    legend.text = element_text(color = "black"),
    legend.title = element_text(color = "black"),
    panel.background = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_line(color = "lightgray", size = 0.5),
    panel.grid.minor = element_line(color = "lightgray", size = 0.25),
    axis.line = element_line(color = "black")
  )

#2. GC Content Distribution
ggplot(contig_stats, aes(x = as.numeric(gsub("%", "", GC_content)))) +
  geom_density(fill = "lightgreen", alpha = 0.8) +
  theme(
    axis.text = element_text(color = "black")
  ) +
  labs(title = "GC Content Distribution",
       x = "GC Content (%)",
       y = "Density")

#3. Contig Length vs. GC Content Scatter Plot; This helps reveal any relationship between GC content and contig length.
ggplot(contig_stats, aes(x = seq_len, y = as.numeric(gsub("%", "", GC_content)))) +
  geom_point(alpha = 0.5, color = "darkblue") +
  theme_minimal() +
  labs(title = "Contig Length vs GC Content",
       x = "Contig Length (bp)",
       y = "GC Content (%)")

#4. Contig Length vs. Coverage Scatter Plot; This scatter plot helps you identify if coverage is correlated with contig length.
ggplot(contig_stats, aes(x = seq_len, y = cov)) +
  geom_point(alpha = 0.5, color = "purple") +
  theme_minimal() +
  labs(title = "Contig Length vs Coverage",
       x = "Contig Length (bp)",
       y = "Coverage")

#5. Heatmap of GC Content and Coverage; This heatmap shows the relationship between GC content and coverage.
ggplot(contig_stats, aes(x = as.numeric(gsub("%", "", GC_content)), y = cov)) +
  geom_bin2d(bins = 30) +
  scale_fill_viridis_c() +
  theme_minimal() +
  labs(title = "GC Content vs Coverage",
       x = "GC Content (%)",
       y = "Coverage")

#6. Bar Plot of Top N Contigs by Length; This plot highlights the longest contigs.
top_contigs <- contig_stats %>%
  arrange(desc(seq_len)) %>%
  head(20)  # Top 20 longest contigs

ggplot(top_contigs, aes(x = reorder(contig_name, seq_len), y = seq_len)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Top 20 Longest Contigs",
       x = "Contig Name",
       y = "Length (bp)")

#7. Coverage Distribution Across Contigs; This shows the spread of coverage values.
ggplot(contig_stats, aes(x = cov)) +
  geom_density(fill = "orange", alpha = 0.7) +
  theme_minimal() +
  labs(title = "Coverage Distribution",
       x = "Coverage",
       y = "Density")


