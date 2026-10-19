import pandas as pd


def summarize_bmi(data: pd.DataFrame) -> pd.DataFrame:
    """Summarize BMI by income group and gender, excluding incomplete rows."""
    complete = data.dropna(subset=["IncomeGroup", "Gender", "BMI"])
    return (
        complete.groupby(["IncomeGroup", "Gender"])
        .agg(
            n=("BMI", "size"),
            mean_BMI=("BMI", "mean"),
            sd_BMI=("BMI", "std"),
            median_BMI=("BMI", "median"),
        )
        .reset_index()
        .sort_values(["IncomeGroup", "Gender"])
        .reset_index(drop=True)
    )
