"""
Tests pour le module __main__ de basic_python_app.
"""
import pytest
from unittest.mock import patch
from io import StringIO
from basic_python_app.__main__ import main

def test_main_output():
    """
    Test que la fonction main() affiche correctement le message attendu.
    """
    with patch('sys.stdout', new=StringIO()) as fake_out:
        main()
        assert fake_out.getvalue().strip() == "Hello from basic_python_app!"

def test_main_execution():
    """
    Test que la fonction main() s'exécute sans erreur.
    """
    try:
        main()
        assert True
    except Exception as e:
        pytest.fail(f"L'exécution de main() a levé une exception: {e}")
