# Google_ML Project - Environment Reset Guide

If you've installed packages like numpy, matplotlib, etc., and want to uninstall them and start from scratch, you have a few safe options. This repo includes a helper script to make it easy.

## Quick options

- Uninstall common ML packages from the current Python environment:
  - macOS/Linux/Windows (PowerShell use `python` accordingly):
    - `bash clean_env.sh`

- Uninstall ALL third-party pip packages from the current environment (dangerous):
  - `bash clean_env.sh full`
  - You'll be prompted to confirm.

- Create a fresh virtual environment (recommended):
  - `bash clean_env.sh venv .venv`
  - Then activate it:
    - macOS/Linux: `source .venv/bin/activate`
    - Windows (PowerShell): `.venv\Scripts\Activate.ps1`
    - Windows (cmd): `.venv\Scripts\activate.bat`

## Manual steps (if you prefer)

### Using pip + venv (recommended)
1. Create a fresh venv at the project root:
   - macOS/Linux: `python3 -m venv .venv && source .venv/bin/activate`
   - Windows: `python -m venv .venv` then activate using one of the commands above.
2. Ensure pip is up to date: `python -m pip install --upgrade pip`
3. Start clean by not installing anything until needed. If you later want to add packages, install them inside the venv.

### Using conda (if you use Anaconda/Miniconda)
1. Create a fresh environment: `conda create -n google_ml_clean python=3.11 -y`
2. Activate it: `conda activate google_ml_clean`
3. Install packages only as needed.
4. To remove an environment entirely: `conda remove -n google_ml_clean --all`

## Notes
- The notebook `binary_classification.ipynb` imports: keras, pandas, numpy, plotly, and others. If you want to run it again later, you'll need to reinstall the required packages in your chosen environment. Example:
  - `pip install numpy pandas plotly keras tensorflow`
- To truly revert the global Python environment, prefer creating and using project-specific virtual environments to avoid system-wide changes.

## What does `clean_env.sh` do?
- Default run (`bash clean_env.sh`) attempts to uninstall common DS/ML libraries (numpy, matplotlib, pandas, plotly, seaborn, scikit-learn, scipy, jupyter, keras, tensorflow, torch, xgboost, lightgbm, etc.) if they are present.
- `bash clean_env.sh full` will attempt to uninstall all third-party pip packages found by `pip freeze` from the current Python interpreter. This is irreversible for that environment unless you reinstall packages.
- `bash clean_env.sh venv <name>` creates a new virtual environment (default `.venv`) and prints activation instructions.
