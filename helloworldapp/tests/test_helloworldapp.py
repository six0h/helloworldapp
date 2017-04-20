#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
test_helloworldapp
----------------------------------

Tests for `helloworldapp` module.
"""

import pytest

from helloworldapp import helloworldapp as _sut

def test_hello():
    assert 'Hello World!' in _sut.hello()

def test_named_hello():
    assert 'Hello test World!' in _sut.respond_with_name('test')
