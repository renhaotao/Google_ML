#!/usr/bin/env bash
# Clean/uninstall common ML/data-science packages to start from scratch
# Usage:
#   bash clean_env.sh            # uninstall common packages in current Python env
#   bash clean_env.sh full       # uninstall ALL third-party pip packages (dangerous)
#   bash clean_env.sh venv myenv # create a fresh virtualenv named myenv and activate instructions

set -euo pipefail

command -v python >/dev/null 2>&1 || { echo "python not found in PATH"; exit 1; }
PY=$(command -v python)
PIP="${PY} -m pip"

info() { echo "[clean_env] $*"; }

if [[ "${1:-}" == "venv" ]]; then
  NAME=${2:-.venv}
  info "Creating fresh virtual environment at ${NAME}"
  ${PY} -m venv "${NAME}"
  info "To activate on macOS/Linux: source ${NAME}/bin/activate"
  info "To activate on Windows:    ${NAME}\\Scripts\\activate"
  exit 0
fi

if [[ "${1:-}" == "full" ]]; then
  info "This will uninstall ALL third-party pip packages from current env."
  read -r -p "Proceed? [y/N] " ans
  if [[ "${ans:-}" != "y" && "${ans:-}" != "Y" ]]; then
    info "Aborted."
    exit 0
  fi
  # Freeze third-party packages and uninstall
  ${PY} -m pip freeze --disable-pip-version-check | xargs -n1 ${PY} -m pip uninstall -y || true
  info "All pip packages removed (except those managed by the base interpreter)."
  exit 0
fi

# Targeted remove: common DS/ML libraries likely installed
PKGS=(
  numpy
  matplotlib
  pandas
  plotly
  seaborn
  scikit-learn
  scipy
  jupyter
  jupyterlab
  ipykernel
  keras
  tensorflow
  torch
  torchvision
  torchaudio
  xgboost
  lightgbm
)

info "Uninstalling common ML/data-science packages if present..."
for pkg in "${PKGS[@]}"; do
  if ${PIP} show "$pkg" >/dev/null 2>&1; then
    info "Uninstalling $pkg"
    ${PIP} uninstall -y "$pkg" || true
  else
    info "$pkg not installed, skipping"
  fi
done

info "Done. Consider creating a fresh venv: bash clean_env.sh venv .venv && source .venv/bin/activate"