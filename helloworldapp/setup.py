#!/usr/bin/env python
# -*- coding: utf-8 -*-

from setuptools import setup

with open('README.rst') as readme_file:
    readme = readme_file.read()

with open('HISTORY.rst') as history_file:
    history = history_file.read()

requirements = [
    'Flask'
]

test_requirements = [
    # TODO: put package test requirements here
]

setup(
    name='helloworldapp',
    version='0.1.0',
    description="This is a hello world app that should be deployed as part of a technical test",
    long_description=readme + '\n\n' + history,
    author="Cody Halovich",
    author_email='me@codyhalovich.com',
    url='https://github.com/six0h/helloworldapp',
    packages=[
        'helloworldapp',
    ],
    package_dir={'helloworldapp':
                 'helloworldapp'},
    include_package_data=True,
    install_requires=requirements,
    zip_safe=False,
    keywords='helloworldapp',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'Natural Language :: English',
        "Programming Language :: Python :: 2",
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
    ],
    test_suite='tests',
    tests_require=test_requirements
)
