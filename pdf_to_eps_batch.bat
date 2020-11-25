@echo on
for %%P in (*.pdf) do (
pdftocairo -ps -origpagesizes %%P
ren %%~nP.ps %%~nP.eps
)
