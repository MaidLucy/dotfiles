#!/usr/bin/python
import os
import sys
import xml.etree.ElementTree as ET

path = sys.argv[1]
if not os.path.exists(path):
    print('{} does not exist'.format(path))
    exit()

tree = ET.parse(path)
root = tree.getroot()

for plugin in tree.findall('Plugin'):
    uri = plugin.find('Info').find('URI').text
    name = plugin.find('Info').find('Name').text
    print('''    {{
        name = "{}"
        type = lv2
        plugin = "{}"
        control = {{'''.format(name, uri))
    data = plugin.find('Data')
    for parameter in data.findall('Parameter'):
        symbol = parameter.find('Symbol').text
        value = parameter.find('Value').text
        print('            "{}" = {}'.format(symbol, value))
    print('''        }
    }''')
