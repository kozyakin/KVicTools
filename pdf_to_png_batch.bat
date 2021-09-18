@echo on
for %%P in (*.pdf) do (
pdftocairo -png -singlefile %%P
)
