from setuptools import setup, find_packages

setup(
    name="basic_python_app",
    version="0.1.0",
    package_dir={"": "."},
    packages=find_packages(),
    py_modules=["main"],
    entry_points = {
        "console_scripts": [
            "basic_python_app = main:main",
        ]
    }
)
