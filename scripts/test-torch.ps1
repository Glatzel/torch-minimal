param( $pixi_python_env = "py311" )
Set-Location $PSScriptRoot
Set-Location ..

pixi run -e "$pixi_python_env" python -c "import torch; print(torch.__version__); print(torch.__config__.show());print(torch.__file__)"
