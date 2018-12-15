# -*- coding: utf-8 -*-
"""
Created on Fri Dec 14 02:49:31 2018

@author: U1
"""

#Current version uses a lot of code from the following sources to get started.
#This must be modified to optimize results as time moves on!
#Current sources:
#   https://stackoverflow.com/questions/49008074/how-to-create-a-neural-network-with-regression-model

import numpy as np
import pandas as pd
import sys


import os
from errno import EEXIST


import mysql.connector  #conda install mysql-connector-python
import mysql.connector.errors
from mysql.connector import errorcode

import time

HOST = 'localhost'
USER = 'root'
DB = 'clinicdb'

password = 'ZakVezThok888!' #getpass.getpass("Database password for user istreamRead:\n")
conn = mysql.connector.connect(host=HOST, user=USER, passwd=password, database=DB)
#Note for below: resolution width currently excluded, since the dataset was designed specifically where only 16:9 videos were transcoded (at the time of this writing)
df = pd.read_sql('''SELECT table_name FROM information_schema.tables where table_schema = "clinicdb";''', con=conn)
tables = list(df['table_name'])
print()
for t in tables:
    print("\\textbf{%s}:" % t.upper().replace("_", "\\_"))
    print("\\begin{itemize}")
    dft = pd.read_sql('''SELECT * FROM `%s`;''' % t, con=conn)
    count = 0
    for index, row in dft.iterrows():
        print("\\item ", end="")
        for col in list(dft.columns):
            if col != dft.columns[-1]:
                s1 = str(row[col]).replace(r"$", r"\$")
                s2 = s1.replace(r"_", r"\_")
                s3 = s2.replace(r"%", r"\%")
                print(s3, end='; ')
        print()
        count += 1
    if count == 0:
        print("\\item ~")
    print(r"~\\\\")
    print("\\end{itemize}")





conn.close()

