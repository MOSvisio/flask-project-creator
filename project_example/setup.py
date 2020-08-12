from setuptools import setup

setup(
	name="project_example",
	packages=["project_example"],
	include_package_data=True,
	install_requires=[
		"flask",
		"flask_sqlalchemy"
	],
)
