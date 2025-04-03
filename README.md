# Return Predictability and Fund Evaluation

This repository contains the full code, data, and report for a group project in the **Empirical Finance (IB9Y60)** module at Warwick Business School. 

## 📌 Project Overview

The objective of this project is to evaluate the role of volatility in predicting future asset returns and assess the performance of selected mutual funds and portfolios.

We examine:
- Whether realized and GARCH-based conditional volatility predict market returns
- How macroeconomic volatility (and credit spreads) impact GDP growth
- Fund evaluation using the Fama-French 5-factor model and Sharpe ratios
- Construction and performance evaluation of a value-weighted “Magnificent Seven” tech stock portfolio

---

## 📂 Repository Structure

- **`Group_2_All_Parts_Codes.ipynb`**  
  A single notebook that performs the entire analysis and generates all relevant tables and plots.

- **`Group_2.pdf`**  
  The final written report submitted for evaluation.

- **Data Files**  
  - `VAR_Data.xlsx`, `credit_spread.csv`, `fama_french_data.csv`, etc.  
    These include all the raw datasets required to reproduce the analysis.
  
- **Output Files**  
  - `cumulative_returns_comparison.png`  
    Example of a plot generated from the notebook.

- **Other Files**  
  - `Question 2.do`, `dataq2.dta`  
    Supporting files related to the Part 2 of the project.

## ▶️ How to Run

1. **Clone the repository** using the command below:
   ```bash
   git clone https://github.com/shreyasxi/Return-Predictability-and-Fund-Evaluation.git
   cd Return-Predictability-and-Fund-Evaluation
   ```

2. Open Group_2_All_Parts_Codes.ipynb in Jupyter Notebook or VS Code.

3. Run all cells. The notebook will:
   - Load all datasets from the repo
   - Run predictive models, regressions, and time series analysis
   - Generate plots used in the report

4. Python dependencies can be installed via:
   ```bash
   pip install -r requirements.txt
    ```
