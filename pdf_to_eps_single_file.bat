chcp 1251
@echo on
for %%P in (%1) do (
pdftocairo -ps -origpagesizes "%%P"
ren "%%~nP.ps" "%%~nP.eps"
)
