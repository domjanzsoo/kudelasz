import sys
import shutil
import os.path as path
from termcolor import colored
from colorama import init as colorama_init
from colorama import Fore
from colorama import Style

colorama_init()

if len(sys.argv) < 2:
    print(f'{Fore.RED}Environment argument is required{Style.RESET_ALL}')
    quit()

env = sys.argv[1]

print(f'Creating local setting file for {env}')

current_dir = path.dirname(__file__)

print(current_dir)

this_dir = path.dirname(__file__)
filename = path.realpath("{0}/settings/prod_settings.py".format(this_dir))

file_setting_path = path.join(current_dir, f'settings\\{env}_settings.py')
target_path = r'./local_settings.py'

print(filename)
if not path.isfile(filename):
    print(f'{Fore.RED}No settings file found for the given environment{Style.RESET_ALL}')
    quit()


# shutil.copyfile(file_setting_path, target_path)

print('Setting file created')


