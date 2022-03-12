chcp 1251
@echo on
for %%P in (%1) do (
pdftocairo -png -r 300 -singlefile "%%P"
)
