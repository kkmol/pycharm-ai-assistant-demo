FROM public.ecr.aws/lambda/python:3.9

MAINTAINER Zuto Data Engineering <shannon.marlow@zuto.com>

COPY poetry.lock pyproject.toml ${LAMBDA_TASK_ROOT}/

RUN pip install poetry==1.1.13 \
    && cd ${LAMBDA_TASK_ROOT} \
    && poetry config virtualenvs.create false \
    && poetry install --no-dev --no-interaction --no-ansi

COPY src/ ${LAMBDA_TASK_ROOT}

CMD [ "app.handler" ]
