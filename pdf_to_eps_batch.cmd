chcp 1251
@echo on
for %%P in (*.pdf) do (
pdftocairo -ps -origpagesizes "%%P"
ren "%%~nP.ps" "%%~nP.eps"
)
