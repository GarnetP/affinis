setwd("/Users/garnet/Desktop/EG_summary_files")

# Load necessary libraries
library(ggplot2)
library(patchwork)
library(readxl)

# Set dataframes. Use read_excel because the .txt file was giving issues
data1 <- read_excel("EG_conslib_TETO_nomancuration/EG_conslib_TETO_nomancuration.familyLevelCount.xlsx")
data2 <- read_excel("TElibEG_affinis/TElibEG_affinis.familyLevelCount.xlsx")
data3 <- read_excel("NOTL_EG_affinis/NOTL_EG_affinis.familyLevelCount.xlsx")

# Set axis ends
x_limits <- c(0, 10000)
y_limits <- c(0, 3500000)

# Make each plot
plot1 <- ggplot(data1, aes(x = copy_number, y = coverage)) +
  geom_point() +
  scale_y_continuous(limits = y_limits) +
  scale_x_continuous(limits = x_limits) +
  labs(title = "Run 6: EG on TEtrimmer (given TElib)") +
  theme_gray() +
  theme(
    axis.title = element_blank())

plot2 <- ggplot(data2, aes(x = copy_number, y = coverage)) +
  geom_point() +
  scale_y_continuous(limits = y_limits) +
  scale_x_continuous(limits = x_limits) +
  labs(title = "Run 2: EG on TElib") +
  theme_gray() +
  theme(
    axis.title = element_blank())

plot3 <- ggplot(data3, aes(x = copy_number, y = coverage)) +
  geom_point() +
  scale_y_continuous(limits = y_limits) +
  scale_x_continuous(limits = x_limits) +
  labs(title = "Run 1: EG RM Search Term Drosophila", y = "Coverage") +
  theme_gray()

# Combine plots
combined_plot <- (plot3 | plot2 | plot1) +
  plot_layout(guides = "collect") &
  theme(
    plot.title = element_text(hjust = 0.5, size = 10),
    axis.title.x = element_text(size = 12),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10)
  )

# Add plot labels
final_plot <- combined_plot + plot_annotation(
  title = "Coverage by Family Copy Number",
  subtitle = NULL,
  caption = NULL,
  tag_levels = NULL,
  theme = theme(
    plot.title = element_text(size = 14),
    plot.margin = margin(5, 5, 5, 5),
    axis.title.x = element_text(size = 12, vjust = -1)
  )
) & labs(x = "Copy Number", y = "Coverage")

# Show final plot
print(final_plot)