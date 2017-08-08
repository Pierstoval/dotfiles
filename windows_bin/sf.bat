@echo OFF
if exist bin/console (
	php bin/console %*
) else (
	if exist app/console (
		php app/console %*
	) else (
		echo "No console found"
	)
)
