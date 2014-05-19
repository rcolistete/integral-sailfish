#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside
import sys
import time
import os

from platform import python_version
timet1=time.time()
from sympy import *
from sympy import __version__
from sympy.interactive.printing import init_printing
from sympy.printing.mathml import mathml
timet2=time.time()
loadingtimeSymPy = timet2-timet1

versionPython = python_version()
versionSymPy = __version__

nonCalculatedIntegral = ""
nonCalculatedIntegralOutput = ""
resultIntegral = ""
resultIntegralSimp = ""
resultOutput = ""
timeIntegral = 0.0
integralErrorMessage = 'Error: integral not calculated'

def fixUnicodeText(text):
    text = text.replace(u"⎽","_")
    text = text.replace(u"ℯ","e")
    text = text.replace(u"ⅈ","i")
    return text

def calculate_Integral(expression,var1,var2,var3):
    global nonCalculatedIntegral, nonCalculatedIntegralOutput, resultIntegral, resultIntegralSimp, resultOutput, timeIntegral

    init_printing(use_unicode=True, num_columns=35)
    timet1=time.time()

    integrand = expression
    diffvar1 = var1.strip()
    diffvar2 = var2.strip()
    diffvar3 = var3.strip()

    integrateExpr = '('+integrand
    if diffvar1:
        integrateExpr += ','+diffvar1
    if diffvar2:
        integrateExpr += ','+diffvar2
    if diffvar3:
        integrateExpr += ','+diffvar3
    integrateExpr += ')'
    try:
        nonCalculatedIntegral = sympify('Integral'+integrateExpr)
    except:
        nonCalculatedIntegral = u'Integral'+integrateExpr
    try:
        resultIntegral = sympify(u'integrate'+integrateExpr)
    except:
        resultIntegral = integralErrorMessage

    resultIntegralSimp = resultIntegral

    timet2=time.time()
    timeIntegral = timet2-timet1

    nonCalculatedIntegralOutput = nonCalculatedIntegral
    resultOutput = resultIntegralSimp

    if (type(nonCalculatedIntegral) != str):
        nonCalculatedIntegralOutput = fixUnicodeText(printing.pretty(nonCalculatedIntegral))
    if (type(resultIntegralSimp) != str):
        resultOutput = fixUnicodeText(printing.pretty(resultIntegralSimp))

    if (timeIntegral > 0.0):
        result = '<FONT COLOR="LightGreen">'+("Calculated after %f s :" % timeIntegral)+'</FONT><br>'
    else:
        result = u""
    if nonCalculatedIntegralOutput:
        result += u'<FONT COLOR="LightBlue">'+(nonCalculatedIntegralOutput.replace(' ','&nbsp;')).replace("\n","<br>")+'<br>=</FONT><br>'
    if (type(resultIntegralSimp) != str):
        result += (resultOutput.replace(' ','&nbsp;')).replace("\n","<br>")
    else:
        result += u'<FONT COLOR="Red">'+((resultOutput.replace(' ','&nbsp;')).replace("\n","<br>"))+'</FONT>'
    return result

