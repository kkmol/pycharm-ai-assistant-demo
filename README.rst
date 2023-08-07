lambda-python-template
======================

Template Repo for AWS Lambda Imges written in Python.

This template is a starting point for any newly created python
lambda images.

Getting Started
---------------

This guide assumes installation within WSL2, using pyenv and Poetry. Although all of these are optional, they are recommended.

Pre-requisites
++++++++++++++

- Docker
- Python (3.10+)
- Terraform


Local Running
+++++++++++++

Firstly, use this repo as a template on github then clone that repository

.. code-block:: bash
    $ git clone https://github.com/zuto/my-lambda
    $ cd my-lambda
    $ poetry install

This setup allows local operation.

Usage
-----

Testing
-------
Functions should have unit tests (and also an example integration test) to ensure
predictible responses, this is powered by pytest, running the
test suite is simple

.. code-block:: bash
    $ poetry install --dev
    $ pytest

Also included in the dev dependencies is coverage and pytest-xdist allowing coverage reporting and distributed testing - generating a html report is very simple.

.. code-block:: bash
    $ coverage run --source=app --module pytest --verbose . && coverage report --show-missing
    $ coverage html

The first line generated a console report, and the second line generates a HTML version which can be found in the htmlcov directory.

Other Resources
---------------
- `[Landing] AWS Lambda <https://aws.amazon.com/lambda/>`_
- `[Docs] AWSLambda Container Mode <https://docs.aws.amazon.com/lambda/latest/dg/images-create.html>`_
- `[Docs] How to use Github Templates <>`_

Related
-------

- `[Repo] ml-events-handler <https://github.com/zuto/ml-events-handler>`_
