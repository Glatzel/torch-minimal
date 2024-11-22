param( $pixi_python_env = "py311" )
Set-Location $PSScriptRoot
Set-Location ..
Set-Location pytorch
pixi run -e "$pixi_python_env" python setup.py bdist_wheel
