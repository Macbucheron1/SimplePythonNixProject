"""
Tests pour le module __main__ de basic_python_app.
"""
import pytest
from unittest.mock import patch
from io import StringIO
from basic_python_app.__main__ import main

def test_main_output():
    """
    Test the output of the main() function.
    """
    with patch('sys.stdout', new=StringIO()) as fake_out:
        main()
        assert fake_out.getvalue().strip() == "Hello from basic_python_app!"

def test_main_execution():
    """
    Test the execution of the main() function without exceptions.
    """
    try:
        main()
        assert True
    except Exception as e:
        pytest.fail(f"The execution of main() raised an exception: {e}")
