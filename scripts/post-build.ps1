param( $pixi_python_env = "py311" )
Set-Location $PSScriptRoot
Set-Location ..
pixi run -e "$pixi_python_env" python -c "import torch; print(torch.__version__); print(torch.cuda.is_available())"
pixi run -e "$pixi_python_env" python setup.py bdist_wheel
