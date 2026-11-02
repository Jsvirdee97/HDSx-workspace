
library(readr)
library(dplyr)
library(ggplot2)

candidate_paths <- c(
  "examples/nhanes-equity/data/nhanes_equity_v6.csv",
  "../../examples/nhanes-equity/data/nhanes_equity_v6.csv"
)

data_path <- candidate_paths[file.exists(candidate_paths)][1]
if (is.na(data_path)) {
  stop("Could not find nhanes_equity_v6.csv")
}

nhanes <- read_csv(data_path, show_col_types = FALSE)

cycle_levels <- sort(unique(as.character(nhanes$Cycle)))

bmi_summary <- nhanes |>
  filter(
    !is.na(BMI),
    !is.na(IncomeGroup),
    !is.na(Age),
    Age >= 20,
    Age <= 80
  ) |>
  mutate(Cycle = factor(Cycle, levels = cycle_levels)) |>
  group_by(Cycle, IncomeGroup) |>
  summarise(
    mean_bmi = mean(BMI),
    .groups = "drop"
  )

revised_plot <- ggplot(
  bmi_summary,
  aes(x = Cycle, y = mean_bmi, color = IncomeGroup, group = IncomeGroup)
) +
  geom_line(linewidth = 0.8) +
  geom_point(size = 2.5) +
  scale_color_viridis_d(option = "D", end = 0.85) +
  scale_y_continuous(
    limits = c(0, 35),
    breaks = seq(0, 35, by = 5),
    expand = expansion(mult = c(0, 0.02))
  ) +
  labs(
    title = "Mean BMI by income group across NHANES cycles",
    subtitle = "Adults aged 20-80; the supplied file includes 1999-2018 and 2021-2023",
    x = "NHANES cycle",
    y = "Mean BMI (kg/m²)",
    color = "Income group",
    caption = paste(
      strwrap(
        paste(
          "Unweighted sample means; excludes records missing BMI, income group, or age.",
          "The supplied file has no 2019-2020 cycle. Descriptive means do not establish",
          "causation or account for the NHANES survey design."
        ),
        width = 115
      ),
      collapse = "\n"
    )
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.caption = element_text(hjust = 0, size = 9)
  )

print(revised_plot)

ggsave(
  "assignments/assignment05-visualization/submission/revised-plot.png",
  revised_plot,
  width = 9,
  height = 6,
  dpi = 300
)
