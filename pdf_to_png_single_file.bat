@echo on
for %%P in (%1) do (
pdftocairo -png -singlefile %%P
)
