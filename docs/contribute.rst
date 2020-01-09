Information for contributors
============================

We would be happy to receive contributions!


Setting up the documentation build system
-----------------------------------------

The documentation is built using `Sphinx <https://sphinx-doc.org/>`_, `Python <https://python.org/>`_, `sphinxcontrib-matlabdomain <https://pypi.python.org/pypi/sphinxcontrib-matlabdomain>`_, and `sphinxcontrib-bibtex <https://pypi.python.org/pypi/sphinxcontrib-bibtex>`_. Building requires using a shell, for example ``bash``.


To install the necessary Python dependencies, create a virtual environment, e.g., with ``virtualenv <environment>``, and activate it afterwards with ``<environment>/bin/activate``. Then install the dependencies using ``pip``::

    pip install sphinx
    pip install sphinxcontrib-matlabdomain
    pip install sphinxcontrib-bibtex
    pip install sphinx-rtd-theme


To build the documentation:

    * Activate the virtual environment where the necessary dependencies are installed in.
    * ``cd`` to ``docs/``, then run ``make html``. (To clean previously built documentation, run ``make clean`` first).

