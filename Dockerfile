ARG PYTHON_IMAGE_TAG=3.12.2-slim
FROM python:${PYTHON_IMAGE_TAG}

ARG ANSIBLE_VERSION
ARG ANSIBLE_LINT_VERSION

ARG TARGETPLATFORM

# Add piwheels repository
RUN case "${TARGETPLATFORM:-linux/amd64}" in \
    linux/arm/v7 | linux/arm/v6 | linux/arm64) \
        echo "[global]" > /etc/pip.conf && \
        echo "extra-index-url=https://www.piwheels.org/simple" >> /etc/pip.conf ;; \
    esac


# Install Ansible
RUN pip install --no-cache-dir --only-binary cryptography \
	ansible${ANSIBLE_VERSION:+==$ANSIBLE_VERSION}

ENTRYPOINT ["ansible"]
CMD ["--version"]
